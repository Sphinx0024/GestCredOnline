using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.OAuth;
using System.Security.Claims;
using System.Threading.Tasks;

namespace GestCredOnline.WebAPI.Providers
{
    public class OAuthorizeProvider : OAuthAuthorizationServerProvider
    {
        private readonly string _publicClientId;
         
        public OAuthorizeProvider(string publicClientId)
        {
            if (publicClientId == null)
            {
                throw new ArgumentNullException("publicClientId");
            }
            _publicClientId = publicClientId;
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        { 
            var userName = context.UserName;
            var password = context.Password;

            new AuthorizationServerProvider().SetCORSPolicy(Helpers.h_config.CORS_Allow, context.OwinContext);

            var user = Helpers.h_Clients.GetClientConnexion(userName, password);
            if (user != null)
            {
                ClaimsIdentity oAuthIdentity = new ClaimsIdentity(context.Options.AuthenticationType);
                ClaimsIdentity cookiesIdentity = new ClaimsIdentity(context.Options.AuthenticationType);

                AuthenticationProperties properties = CreateProperties(user); 
                 
                var claims = new List<Claim>()
                        {
                            new Claim(ClaimTypes.Sid, user["CLIENT"].ToString()),
                            new Claim(ClaimTypes.Name, user["NOM"].ToString()),
                            new Claim(ClaimTypes.MobilePhone, user["TEL"].ToString()),
                            new Claim (ClaimTypes.Role, "User"),
                        };
                oAuthIdentity = new ClaimsIdentity(claims, Startup.OAuthOptions.AuthenticationType);
                 
                properties.ExpiresUtc = DateTime.Now.AddDays(2);
                AuthenticationTicket ticket = new AuthenticationTicket(oAuthIdentity, properties);
                context.Validated(ticket);
                context.Request.Context.Authentication.SignIn(cookiesIdentity);

            }
            else
            {
                context.SetError("invalid_grant", "Votre racine ou le OTP n'est pas correcte");
            }
        }


        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            foreach (KeyValuePair<string,
            string> property in context.Properties.Dictionary)
            {
                context.AdditionalResponseParameters.Add(property.Key, property.Value);
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientAuthentication
      (OAuthValidateClientAuthenticationContext context)
        {
            // Resource owner password credentials does not provide a client ID.
            if (context.ClientId == null)
            {
                context.Validated();
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientRedirectUri
        (OAuthValidateClientRedirectUriContext context)
        {
            if (context.ClientId == _publicClientId)
            {
                Uri expectedRootUri = new Uri(context.Request.Uri, "/");
                if (expectedRootUri.AbsoluteUri == context.RedirectUri)
                {
                    context.Validated();
                }
            }

            return Task.FromResult<object>(null);
        }


        public static AuthenticationProperties CreateProperties(DataRow us)
        { 
            IDictionary<string, string> data =
                new Dictionary<string, string>()
                   {
                        { "nomComplet", us["NOM"].ToString()},
                        { "racine", us["CLIENT"].ToString()}
                   }; 
            return new AuthenticationProperties(data);
        }

    }
}