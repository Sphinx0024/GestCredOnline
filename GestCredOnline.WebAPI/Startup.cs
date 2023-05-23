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
        public void Configuration(IAppBuilder app)
        {
            var config = new HttpConfiguration();
            app.UseWebApi(config);
            ConfigureAuth(app);
        }
    }
}