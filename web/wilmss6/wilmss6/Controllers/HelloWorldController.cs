using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace wilmss6.Controllers
{
    public class HelloWorldController : Controller
    {
        // View and Controller
        // http://localhost:56981/Controller/ActionMethod/Parameter
        // http://localhost:56981/HelloWorld/Index
        // http://localhost:56981/HelloWorld/Welcome
        // GET: /HelloWorld/
        public string Index()
        {
            return "Welcome to <b>Wilson Mobile Software Solutions, LLC</b>";
        }

        public string Welcome(string name="Default Name", int numTimes=1)
        {

            var htmlString = HttpUtility.HtmlEncode("Hello " + name + ", NumTimes is: " + numTimes);

            return htmlString;
        }
    }
}
