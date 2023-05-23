using Microsoft.Owin;
using Microsoft.Owin.Security.OAuth;
using System;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace GestCredOnline.WebAPI.Providers
{
    public class AuthorizationServerProvider : OAuthAuthorizationServerProvider
    {
        public override Task MatchEndpoint(  OAuthMatchEndpointContext context)
        {
            SetCORSPolicy(Helpers.h_config.CORS_Allow, context.OwinContext);
            if (context.Request.Method == "OPTIONS")
            {
                context.RequestCompleted();
                return Task.FromResult(0);
            }

            return base.MatchEndpoint(context);
        }
         
        public void SetCORSPolicy(string allowedUrls, IOwinContext context)
        { 
            if (!String.IsNullOrWhiteSpace(allowedUrls))
            {
                var list = allowedUrls.Split(',');
                if (list.Length > 0)
                {
                    string origin = context.Request.Headers.Get("Origin");
                    var found = list.Where(item => item == origin).Any();
                    if (found)
                    {
                        context.Response.Headers.Add("Access-Control-Allow-Origin",
                                                     new string[] { origin });
                    }
                }
            }
            context.Response.Headers.Add("Access-Control-Allow-Headers", new string[] { "Authorization", "Content-Type" });
            context.Response.Headers.Add("Access-Control-Allow-Methods", new string[] { "OPTIONS", "POST" });
        }

    }
}