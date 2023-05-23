using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Threading.Tasks;
using GestCredOnline.WebAPI.Helpers;

namespace GestCredOnline.WebAPI.Controllers
{
    public class ClientController : ApiController
    {
        [HttpGet]
        public bool GetClientIdentification(string id)
        {
            DataRow R = Helpers.h_Clients.GetClientByRacine(id);
            {
                return (R != null) ? true : false; 
            }; 
        }

        [HttpGet]
        public async Task<bool> GetAskOTP(string id)
        {

            try
            {

                DataRow D = null;
                DataRow R = Helpers.h_Clients.GetClientOTP(id);
                string Telephone = "";
                if ((R != null) ? true : false)
                {
                    string _OTP = R["OTP"] != null ? R["OTP"].ToString() : "";
                    _OTP = "OTP de connexion BNI-GestCred : " + _OTP;
                    D = Helpers.h_Clients.GetClientFromORION(id);
                    if (D != null)
                    {
                        Telephone = (D["TEL"] != null ? D["TEL"].ToString() : "");
                    }

                    // Telephone = "0747683181"; 
                    EventLogger.Instance.WriteLog("Debut sms");
                    return await Helpers.h_Clients.SendSms("Share2021", "Share@@2021", _OTP, "BNI", Telephone);
                }
                else
                {
                    string _OTP = GestCredOnline.Helpers.RandomPassword.Generate(6, 7);
                    Helpers.h_Clients.PostClientOTP(id, _OTP);
                    D = Helpers.h_Clients.GetClientFromORION(id);
                    if (D != null)
                    {
                        Telephone = (D["TEL"] != null ? D["TEL"].ToString() : "");
                    }
                    // Telephone = "0747683181";
                    _OTP = "OTP de connexion BNI-GestCred : " + _OTP;
                    return await Helpers.h_Clients.SendSms("Share2021", "Share@@2021", _OTP, "BNI", Telephone);
                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        
        }
         

        [HttpPost]
        public bool PostConnexion ([FromBody] AuthModel authModel )
        {
            DataRow R = Helpers.h_Clients.GetClientConnexion(authModel.username, authModel.password);
            {
                return (R != null) ? true : false;
            };
        }


        [HttpGet]
        public List<Models.EtatRequest> GetEtatRequest(string id)
        {
            return Helpers.h_Clients.GetEtatRequests(id);
        }

    }

   public  class AuthModel
    {
        public string username { get; set; }
        public string password { get; set; }
    }
}
