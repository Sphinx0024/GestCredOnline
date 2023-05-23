using Microsoft.AspNet.OData;
using Microsoft.AspNet.OData.Query;
using Microsoft.AspNet.OData.Routing;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web.Http;
using System.Security.Claims;

namespace GestCredOnline.WebAPI.Controllers
{
    using Models;
    [ODataRoutePrefix("Request")]
    [EnableQuery]
    [Authorize]
    public class RequestController : ODataController
    {

        private readonly Models.GestCredOnline_DBEntities _db = new GestCredOnline_DBEntities();
        private static ODataValidationSettings _validationSettings = new ODataValidationSettings();

        [ODataRoute]
        [AllowAnonymous]
        [EnableQuery(PageSize = 700, AllowedQueryOptions = AllowedQueryOptions.All, AllowedArithmeticOperators = AllowedArithmeticOperators.All)]
        public IHttpActionResult Gets()
        {
            System.Security.Claims.ClaimsIdentity identity = (System.Security.Claims.ClaimsIdentity)User.Identity;
            System.Security.Claims.Claim UsID = identity.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Sid);
             
             if(UsID != null)
            {
                return Ok(_db.Request.Where(c=>c.AccountRacine ==  UsID.Value).AsQueryable());
            }
            else
            {
                return Ok();
            }
            
        }

        [EnableQuery] 
        [ODataRoute("({key})")]
        public IHttpActionResult Get(long key)
        {
            return Ok(_db.Request.FirstOrDefault(c => c.RequestID == key));
        }

        [HttpDelete]
        [ODataRoute]
        public async Task<IHttpActionResult> Delete([FromODataUri] int key)
        {
            Request US = await _db.Request.FindAsync(key);
            if (US == null)
            {
                return NotFound();
            }
            _db.Request.Remove(US);
            await _db.SaveChangesAsync();
            return StatusCode(HttpStatusCode.NoContent);
        }

        [HttpPost]
        [ODataRoute]
        public async Task<IHttpActionResult> Post(Request US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            string rq = GestCredOnline.Helpers.RandomPassword.Generate(9); //"GC" + System.DateTime.Now.ToString("ddMMyyyy") ;
            US.Reference = rq;
            US.Ref_req = rq;
            _db.Request.Add(US);

            try
            {
                await _db.SaveChangesAsync();
                return Created(US);
            }
            
            catch (DbEntityValidationException e)
            {
                string toto = "";
                foreach (var eve in e.EntityValidationErrors)
                {
                    toto += "Entity of type " + eve.Entry.Entity.GetType().Name + " in state " + eve.Entry.State + " has the following validation errors:";
                    foreach (var ve in eve.ValidationErrors)
                    {
                        toto += "- Property: "+ve.PropertyName+", Error: "+ve.ErrorMessage+"";
                    }
                }
                return BadRequest(toto);
            }
              
        }

        [HttpPatch]
        [ODataRoute("({key})")]
        public async Task<IHttpActionResult> Patch([FromODataUri] long key, Delta<Request> US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var entity = await _db.Request.FindAsync(key);
            if (entity == null)
            {
                return NotFound();
            }
            US.Patch(entity);
            try
            {
                await _db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                if (!Exists(key))
                {
                    return NotFound();
                }
                else
                {
                    return BadRequest(ex.ToString());
                }
            }
            try
            {
               await  updatescore(key);
            }
            catch (System.Exception)
            {
 
            }
         
            return Updated(entity);
        }

        [HttpPut]
        [ODataRoute("({key})")]
        public async Task<IHttpActionResult> Put([FromODataUri] long key, Request US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (key != US.RequestID)
            {
                return BadRequest();
            }

            _db.Entry(US).State = EntityState.Modified;

            try
            {
                await _db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                if (!Exists(key))
                {
                    return NotFound();
                }
                else
                {
                    return BadRequest(ex.ToString());
                }
            }

            return Updated(US);
        }

        private async Task <bool> updatescore(long key)
        {
            Request R = _db.Request.Where(c => c.RequestID == key).FirstOrDefault();
            if( R != null)
            {
                CoreCalcul.CustomerScore cs = new CoreCalcul.CustomerScore();
                if ((R.Client.EstExploitantAgricole != null ? R.Client.EstExploitantAgricole : false) == true)
                {
                    CoreCalcul.ScoringCriteriaExploitant scE = new CoreCalcul.ScoringCriteriaExploitant();
                    scE.Age =  (R.Client.DateNaissance != null ? (int) (R.Client.DateNaissance.Value - System.DateTime.Now).TotalDays / 365 : 0) ;
                    scE.Anciennete = (R.Client.DateCompte != null ? (int)(R.Client.DateCompte.Value - System.DateTime.Now).TotalDays / 365 : 0);  //R.AncienneteClient != null ? R.AncienneteClient.Value : 0;
                    scE.DureePret = R.CreditDuree != null ? R.CreditDuree.Value : 0;
                    scE.EstEpargnant = R.Client.AcompteEpargne != null ? R.Client.AcompteEpargne.Value : false;
                    scE.EstExploitantAgricole = true;
                    scE.Nationnalite = R.Client.Nationalite ;
                    scE.Sexe =   ( R.Client.Sexe == "M" ? 'M': 'F');
                    scE.TauxEndettement =  R.CreditTauxEndettement != null ? float.Parse( R.CreditTauxEndettement.Value.ToString() ): 0;
                    scE.TotalRevenu = R.Client.RevenuTotal != null ? R.Client.RevenuTotal.Value : 0;
                    cs = CoreCalcul.CalculScoring.CalculScore(scE);
                }
                else
                {
                    CoreCalcul.ScoringCriteriaSalarie scS = new CoreCalcul.ScoringCriteriaSalarie();

                    scS.Grade = R.Client.EmployeurCrade != null ? int.Parse( R.Client.EmployeurCrade) : 0 ;
                    scS.EstEpargnant = R.Client.AcompteEpargne != null ? R.Client.AcompteEpargne.Value : false; 
                    scS.Age = (R.Client.DateNaissance != null ? (int)(R.Client.DateNaissance.Value - System.DateTime.Now).TotalDays / 365 : 0);
                    scS.Anciennete = (R.Client.DateCompte != null ? (int)(R.Client.DateCompte.Value - System.DateTime.Now).TotalDays / 365 : 0);  //R.AncienneteClient != null ? R.AncienneteClient.Value : 0;
                    scS.DureePret = R.CreditDuree != null ? R.CreditDuree.Value : 0;
                    scS.EmployeurEstAgree = R.Client.EmployeurEstAgree != null ? R.Client.EmployeurEstAgree.Value : false ;
                    scS.NombreAnneeEmployeurExistance = R.Client.EmployeurNbAnneeExiste != null ?  int.Parse(R.Client.EmployeurNbAnneeExiste) : 0 ;
                    scS.Profession = R.Client.EmployeurProfession != null ? int.Parse( R.Client.EmployeurProfession) : 0;
                    scS.SegmentEmployeur = R.Client.EmployeurSegment != null ? int.Parse(R.Client.EmployeurSegment) : 0;
                    scS.TauxEndettement = float.Parse( R.CreditTauxEndettement.ToString()) ;
                    scS.TauxPret = float.Parse(R.CreditTaux.ToString());
                    scS.TotalRevenu = R.Client.RevenuTotal != null ? R.Client.RevenuTotal.Value : 0  ; 
                    cs = CoreCalcul.CalculScoring.CalculScore(scS); 
                }

                R.Note = cs.Note;
                R.Score = cs.Score;
                R.Risque = cs.Risque;
                _db.SaveChanges();
                  
                string Msg = "";
                if (eliminationClient(R)) 
                {
                    R.DemandeEtat = 4;
                    _db.SaveChanges();
                    // return await Helpers.h_Clients.SendSms("Share2021", "Share@@2021", Msg, "BNI", R.Client.CellPhone);
                    Msg = "Bonjour M/Mme/Mlle \n Votre demande de crédit n'a pas abouti. Nous vous recommandons de vous rendre en agence afin de rencontrer votre gestionnaire. ";
                    await Helpers.h_Clients.SendSms(Msg, R.Client.CellPhone);
                }
                else
                {
                    Msg = "Bonjour M/Mme/Mlle \n Votre demande de crédit est prêt pour envoi .Veillez joindre les documents necessaires . ";
                    await Helpers.h_Clients.SendSms(Msg, R.Client.CellPhone);
                }
            }
            return true;
        }

        private bool eliminationClient(Models.Request R )
        { 
            if ((R.CreditQuotite > 33.33)) {
                return true;
            }

            if (R.Client.EmployeurSegment != "4") { 
            if ((R.Client.EmployeurEstAgree.Value == false))
                {
                    return true;
                }
            }

            if((R.Client.EmployeurDateFinContrat < R.DemandeDate.Value.AddMonths(R.CreditDuree.Value)))
            {
                return true;
            } 
            return false;
        }

        private bool Exists(long key)
        {
            return _db.Request.Count(e => e.RequestID == key) > 0;
        }

        protected override void Dispose(bool disposing)
        {
            _db.Dispose();
            base.Dispose(disposing);
        }


    }
}
