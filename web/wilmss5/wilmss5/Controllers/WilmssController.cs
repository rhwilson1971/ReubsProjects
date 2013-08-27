using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace wilmss5.Controllers
{
    public class WilmssController : Controller
    {
        //
        // GET: /WelcomeToWilmss/

        // This is default frame actionResult
        //public ActionResult Index()
        //{
        //    return View();
        //}

        // GET: /Wilmss
        public string Index()
        {
            return "Wilson Mobile Software Solutions &copy; ";
        }

        // GET: /Wilmss/Helo
        public string Hello()
        {
            return "Hello action method";
        }
    }
}
