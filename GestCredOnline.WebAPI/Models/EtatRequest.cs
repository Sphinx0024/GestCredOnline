using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GestCredOnline.WebAPI.Models
{
    public class EtatRequest
    {
        public long R_ID { get; set; }
        public long RequestID { get; set; }
        public string  AccountRacine { get; set; }
        public string  CreditProgram { get; set; }
        public int DemandeEtat { get; set; }
        public string  Risque { get; set; }
        public long Total { get; set; }
    }
}