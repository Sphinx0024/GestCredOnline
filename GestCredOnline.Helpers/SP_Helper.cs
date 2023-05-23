using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Client;
using Microsoft.SharePoint.Administration;
using System.Security; 

namespace GestCredOnline.Helpers
{
    public static class SP_Helper
    {
        private static ClientContext Ctx = null ;

        public static string  siteUrl = "";
        public static string userLogin = "";
        public static string userPwd = "";

        public static ClientContext GetContext()
        {
            return GetContext(SP_Helper.siteUrl, SP_Helper.userLogin, SP_Helper.userPwd);
        }

        public static ClientContext GetContext( string siteUrl , string userLogin, string userPwd )
        {
            if (SP_Helper.Ctx != null)
            {
              //  ClientContext context = null;
                try
                {
                    SP_Helper.Ctx = new ClientContext(siteUrl);
                    SecureString Pwd = new SecureString();
                    foreach (char c in userPwd)
                    {
                        Pwd.AppendChar(c);
                    } 
                    System.Net.NetworkCredential credentials = new System.Net.NetworkCredential(userLogin, Pwd);
                    SP_Helper.Ctx.Credentials = credentials;
                }
                catch (Exception ex)
                {
                    SP_Helper.Ctx = null;
                }
                return SP_Helper.Ctx;
            }
            else
            {
                return SP_Helper.Ctx;
            }
          //  return context;
        }

        public static List<string> GetGroupMailAdress(string GroupName)
        {
            List<string> LstAdresse = new List<string>();
            try
            {
                using (ClientContext context = SP_Helper.GetContext())
                {
                Group ChfGroup = context.Web.SiteGroups.GetByName(GroupName);
                context.Load(ChfGroup);
                context.Load(ChfGroup.Users);
                context.ExecuteQuery();
                if (ChfGroup != null)
                {
                    foreach (var Us in ChfGroup.Users)
                    {
                        LstAdresse.Add(Us?.Email);
                    }
                }

                LstAdresse = LstAdresse.Where(c => c.Trim() != "").ToList();
            }
            }
            catch (Exception ex)
            {
                throw;
            }

            return LstAdresse;
        }
         
        public static  ListItemCollection Lists( string ListName, string Requete = ""  )
        {
            //System.Linq.Expressions.LambdaExpression. SLExFunc
            ListItemCollection ResultCollection = null; 
            try
            {
                using (ClientContext context = SP_Helper.GetContext())
                { 
                    CamlQuery camlQuery = new CamlQuery();
                    List LoanList = context.Web.Lists.GetByTitle(ListName);
                    camlQuery.ViewXml = Requete;
                    ResultCollection = LoanList.GetItems(camlQuery);
                    context.Load (ResultCollection  ); 
                    context.ExecuteQuery();
                }
            }
            catch (Exception ex)
            {
                 ResultCollection = null;
            }
            return ResultCollection;
        }



    }
}
