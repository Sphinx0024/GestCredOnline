using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using  GestCredOnline.CoreCalcul;

namespace GestCredOnline.WebAPI.Controllers
{
    public class ScoringController : ApiController
    {  
        [HttpPost]
        [ActionName("CalculScoreAgricol")]
        public IHttpActionResult CalculScoreAgricol([FromBody] CoreCalcul.ScoringCriteriaExploitant Crit)
        {
            CoreCalcul.CustomerScore Csr =   CoreCalcul.CalculScoring.CalculScore(Crit);
            return Ok(Csr);
        }




        [HttpPost]
        [ActionName("CalculScoreSalarie")]
        public IHttpActionResult CalculScoreSalarie([FromBody] CoreCalcul.ScoringCriteriaSalarie Crit)
        {
            CoreCalcul.CustomerScore Csr = CoreCalcul.CalculScoring.CalculScore(Crit);
            return Ok(Csr);
        }

        

    }
}
