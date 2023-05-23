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
    [ODataRoutePrefix("Prospect")]
    [EnableQuery] 
   // [Authorize]
    public class ProspectController : ODataController
    { 
        private readonly Models.GestCredOnline_DBEntities _db = new GestCredOnline_DBEntities();
        private static ODataValidationSettings _validationSettings = new ODataValidationSettings();

        [ODataRoute]
        // [AllowAnonymous]
        [EnableQuery(PageSize = 700, AllowedQueryOptions = AllowedQueryOptions.All, AllowedArithmeticOperators = AllowedArithmeticOperators.All)]
        public IHttpActionResult Gets()
        {
            return Ok(_db.Prospects.AsQueryable());
        }

        [EnableQuery]
        [ODataRoute("({key})")]
        public IHttpActionResult Get(long key)
        {
            return Ok(_db.Prospects.FirstOrDefault(c => c.ID == key));
        }

        [HttpDelete]
        [ODataRoute]
        public async Task<IHttpActionResult> Delete([FromODataUri] int key)
        {
            Prospects US = await _db.Prospects.FindAsync(key);
            if (US == null)
            {
                return NotFound();
            }
            _db.Prospects.Remove(US);
            await _db.SaveChangesAsync();
            return StatusCode(HttpStatusCode.NoContent);
        }

        [HttpPost]
        [ODataRoute]
        public async Task<IHttpActionResult> Post(Prospects US)
        { 
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
             
            _db.Prospects.Add(US);
            await _db.SaveChangesAsync();
            return Created(US);
        }

        [HttpPatch]
        [ODataRoute("({key})")]
        public async Task<IHttpActionResult> Patch([FromODataUri] long key, Delta<Prospects> US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var entity = await _db.Prospects.FindAsync(key);
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
        public async Task<IHttpActionResult> Put([FromODataUri] long key, Prospects US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (key != US.ID)
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
            return _db.Prospects.Count(e => e.ID == key) > 0;
        }

        protected override void Dispose(bool disposing)
        {
            _db.Dispose();
            base.Dispose(disposing);
        }


    

    }
}
