using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace GestCredOnline.WebAPI.Controllers
{
    public class EtatRequestController : ApiController
    {
        // GET api/<controller>
        public IEnumerable<string> Get(string id)
        {
            return new string[] { "value1", "value2" };
        }
 
    }
}