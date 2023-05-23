using System.IO;
using System.Net.Http;
using System.Web.Mvc;
using System.Web.Http.Cors; 
using H =  SenyniumX.Activ.BNI.AppClientHelpers;

namespace GestCredOnline.WebAPI.Controllers
{
    //[EnableCors(origins: "http://localhost:51582", headers: "*", methods: "*")]
    [RoutePrefix("v1/Files")]
    public class FilesController : Controller
    {   
        [HttpPost] //HttpResponseMessage
        public  ActionResult  UploadFile()
        { string P = ""; string subFolder = "", folder = "";
            subFolder = Helpers.h_utilitaires.generateRandomString(6);
            folder = string.Format("/{0}/{1}", "Telechargements", subFolder); 
            foreach (string file in Request.Files)
            {
                var FileDataContent = Request.Files[file];
                if (FileDataContent != null && FileDataContent.ContentLength > 0)
                {
                    // take the input stream, and save it to a temp folder using the original file.part name posted
                    var stream = FileDataContent.InputStream;
                    var fileName = Path.GetFileName(FileDataContent.FileName);


                   
                    /// / App_Data / Temp / "
                    var UploadPath = Server.MapPath( string.Format("~{0}", folder));
                    Directory.CreateDirectory(UploadPath);
                    string path = Path.Combine(UploadPath, fileName);
                   
                    try
                    {
                        if (System.IO.File.Exists(path))
                            System.IO.File.Delete(path);
                        using (var fileStream = System.IO.File.Create(path))
                        {
                            stream.CopyTo(fileStream);
                        }
                        // Once the file part is saved, see if we have enough to merge it
                        H.Utils UT = new H.Utils();
                        UT.MergeFile(path);

                        //// App_Data/Temp/"
                        P = string.Format("{0}/{1}" , folder , fileName.Substring(0, fileName.IndexOf(".part_"))); 
                    }
                    catch (IOException ex)
                    {

                        return Json(new { error = ex.HResult, msg = ex.Message }); 
                        //return new HttpResponseMessage()
                        //{
                        //    StatusCode = System.Net.HttpStatusCode.BadRequest,
                        //    Content = new StringContent(ex.ToString())
                        //}; //.Content.Headers.ContentType = new System.Net.Http.Headers. MediaTypeHeaderValue("application/json"); 
                    }
                }
            }

            // if (Request.UserHostName.Contains( "1"))
            // {
            Response.AddHeader("Access-Control-Allow-Origin", "*");
            // }
            return Json(new { code = 200, msg = P });

            //return new HttpResponseMessage()
            //{ 
            //    StatusCode = System.Net.HttpStatusCode.OK,
            //    Content = new StringContent(P)
            //};
            //.Content.Headers.ContentType= new System.Net.Http.Headers.MediaTypeHeaderValue("text/html"); 
        }
         
        [HttpGet]
        public HttpResponseMessage UploadFile1()
        {
            return new HttpResponseMessage()
            {
                StatusCode = System.Net.HttpStatusCode.OK,
                Content = new StringContent("File uploaded.")
            };
        }

    }
}