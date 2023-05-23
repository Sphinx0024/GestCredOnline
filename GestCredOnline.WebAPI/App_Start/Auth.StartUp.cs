using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Microsoft.Owin.Security.OAuth;
using Microsoft.Owin;
using Owin;
using System.Web.Http.Cors;

[assembly: OwinStartup(typeof(GestCredOnline.WebAPI.Startup))]
namespace GestCredOnline.WebAPI
{
	public partial class Startup
	{
        public static OAuthAuthorizationServerOptions OAuthOptions { get; private set; }
        public static string PublicClientId { get; private set; }

        public void ConfigureAuth(IAppBuilder app)
        {
            HttpConfiguration config = new HttpConfiguration();
            PublicClientId = "self";

            var OAuthProvider = new Providers.OAuthorizeProvider(PublicClientId);
             OAuthOptions = new OAuthAuthorizationServerOptions
             { 
                TokenEndpointPath = new PathString("/token"),
                AccessTokenExpireTimeSpan = TimeSpan.FromDays(Helpers.h_config.AuthDuration),             
                AuthorizeEndpointPath = new PathString("/api/Account/ExternalLogin"),
                Provider = OAuthProvider, 
                AllowInsecureHttp = true
            };
            app.UseOAuthBearerTokens(OAuthOptions); 
            //app.UseOAuthAuthorizationServer(options);
            //app.UseOAuthBearerAuthentication(new OAuthBearerAuthenticationOptions());
              
        }
    }
}