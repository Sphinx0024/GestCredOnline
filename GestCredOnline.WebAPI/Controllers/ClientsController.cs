using Microsoft.AspNet.OData;
using Microsoft.AspNet.OData.Query;
using Microsoft.AspNet.OData.Routing;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web.Http;

namespace GestCredOnline.WebAPI.Controllers
{
    using Models;
    [ODataRoutePrefix("Clients")]
    [EnableQuery] 
   // [Authorize]
    public class ClientsController : ODataController
    { 
        private readonly Models.GestCredOnline_DBEntities _db = new GestCredOnline_DBEntities();
        private static ODataValidationSettings _validationSettings = new ODataValidationSettings();

        [ODataRoute]
        // [AllowAnonymous]
        [EnableQuery(PageSize = 700, AllowedQueryOptions = AllowedQueryOptions.All, AllowedArithmeticOperators = AllowedArithmeticOperators.All)]
        public IHttpActionResult Gets()
        {
            return Ok(_db.Client.AsQueryable());
        }

        [EnableQuery]
        [ODataRoute("({key})")]
        public IHttpActionResult Get(long key)
        {
            return Ok(_db.Client.FirstOrDefault(c => c.PersonID == key));
        }

        [HttpDelete]
        [ODataRoute]
        public async Task<IHttpActionResult> Delete([FromODataUri] int key)
        {
            Client US = await _db.Client.FindAsync(key);
            if (US == null)
            {
                return NotFound();
            }
            _db.Client.Remove(US);
            await _db.SaveChangesAsync();
            return StatusCode(HttpStatusCode.NoContent);
        }

        [HttpPost]
        [ODataRoute]
        public async Task<IHttpActionResult> Post(Client US)
        { 
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            GetClientInfosFromBNIDB(ref US);
             
            _db.Client.Add(US);
            await _db.SaveChangesAsync();
            return Created(US);
        }

        [HttpPatch]
        [ODataRoute("({key})")]
        public async Task<IHttpActionResult> Patch([FromODataUri] long key, Delta<Client> US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var entity = await _db.Client.FindAsync(key);
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
            catch (DbUpdateException ex) { return BadRequest(ex.ToString()); }
            return Updated(entity);
        }

        [HttpPut]
        [ODataRoute("({key})")]
        public async Task<IHttpActionResult> Put([FromODataUri] long key, Client US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (key != US.PersonID)
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

        private bool Exists(long key)
        {
            return _db.Client.Count(e => e.PersonID == key) > 0;
        }

        protected override void Dispose(bool disposing)
        {
            _db.Dispose();
            base.Dispose(disposing);
        }


        private void GetClientInfosFromBNIDB (ref Client C)
        {

           var D = Helpers.h_Clients.GetClientFromORION(C.AccountRacine);

            if (D != null)
            {
                C.Nom = (D["NOM"] != null ? D["NOM"].ToString() : "").Split(' ').ToList().First();
                C.Prenom = (D["NOM"] != null ? D["NOM"].ToString() : "").Replace(C.Nom, "").Trim();
                C.Sexe = (D["SEXE"] != null ? D["SEXE"].ToString() : "");
                C.Civilite = (D["CIVILITE"] != null ? D["CIVILITE"].ToString() : "");
                C.PieceDateEtablissement = (D["DATLIVR"] != null ? Helpers.h_utilitaires.ConvertStringToDate(D["DATLIVR"].ToString()) : System.DateTime.Now);
                C.PieceDateExpiration = (D["DATVALID"] != null ? Helpers.h_utilitaires.ConvertStringToDate(D["DATVALID"].ToString()) : System.DateTime.Now);
                C.LieuNaissance = (D["COMMNAIS"] != null ? D["COMMNAIS"].ToString() : "");
                C.PieceNumero = (D["NUMID"] != null ? D["NUMID"].ToString() : "");
                C.CellPhone = (D["TEL"] != null ? D["TEL"].ToString() : "");
                C.OfficePhone = (D["TELEFAX"] != null ? D["TELEFAX"].ToString() : "");
                C.HomePhone = (D["TELETEX"] != null ? D["TELETEX"].ToString() : "");
                C.ConjointNom = (D["NOMMARI"] != null ? D["NOMMARI"].ToString() : "");
                C.ConjointPrenom = (D["PNOMMARI"] != null ? D["PNOMMARI"].ToString() : "");
                C.EmployeurNom = (D["INTRPAR"] != null ? D["INTRPAR"].ToString() : ""); 
                C.DateNaissance = (D["DATNAIS"] != null ? Helpers.h_utilitaires.ConvertStringToDate(D["DATNAIS"].ToString()) : System.DateTime.Now); 
                C.DateCompte = (D["DATOUV"] != null ? Helpers.h_utilitaires.ConvertStringToDate(D["DATOUV"].ToString()) : System.DateTime.Now);
                C.AcompteEpargne = ((D["EPARGNE"] != null ? D["EPARGNE"].ToString() : "") == "" ? false : true); 
                C.PieceTypeID = 1; //(D["TYPEID"] != null ? D["TYPEID"].ToString() : "");
                C.RegimeMatrimonialID = 1; // (D["SITUAMARI"] != null ? D["SITUAMARI"].ToString() : ""); 
            }



            
           

        }

    }
}
