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
    [ODataRoutePrefix("EmployeurContrat")]
    [EnableQuery]
    //[Authorize]
    public class EmployeurContratController : ODataController
    {

        private readonly Models.GestCredOnline_DBEntities _db = new GestCredOnline_DBEntities();
        private static ODataValidationSettings _validationSettings = new ODataValidationSettings();

        [ODataRoute]
        // [AllowAnonymous]
        [EnableQuery(PageSize = 700, AllowedQueryOptions = AllowedQueryOptions.All, AllowedArithmeticOperators = AllowedArithmeticOperators.All)]
        public IHttpActionResult Gets()
        {
            return Ok(_db.EmployeurContrat.AsQueryable());
        }

        [EnableQuery] 
        [ODataRoute("({key})")]
        public IHttpActionResult Get(long key)
        {
            return Ok(_db.EmployeurContrat.FirstOrDefault(c => c.EmployeurContratID == key));
        }

        [HttpDelete]
        [ODataRoute]
        public async Task<IHttpActionResult> Delete([FromODataUri] int key)
        {
            EmployeurContrat US = await _db.EmployeurContrat.FindAsync(key);
            if (US == null)
            {
                return NotFound();
            }
            _db.EmployeurContrat.Remove(US);
            await _db.SaveChangesAsync();
            return StatusCode(HttpStatusCode.NoContent);
        }

        [HttpPost]
        [ODataRoute]
        public async Task<IHttpActionResult> Post(EmployeurContrat US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            _db.EmployeurContrat.Add(US);
            await _db.SaveChangesAsync();
            return Created(US);
        }

        [HttpPatch]
        [ODataRoute("({key})")]
        public async Task<IHttpActionResult> Patch([FromODataUri] long key, Delta<EmployeurContrat> US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var entity = await _db.EmployeurContrat.FindAsync(key);
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
            return Updated(entity);
        }

        [HttpPut]
        [ODataRoute("({key})")]
        public async Task<IHttpActionResult> Put([FromODataUri] long key, EmployeurContrat US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (key != US.EmployeurContratID)
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
            return _db.EmployeurContrat.Count(e => e.EmployeurContratID == key) > 0;
        }

        protected override void Dispose(bool disposing)
        {
            _db.Dispose();
            base.Dispose(disposing);
        }


    }
}
