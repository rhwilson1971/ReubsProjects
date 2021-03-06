﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.SignalR;

namespace LegoList.Controllers
{
    public class HomeController : Controller
    {

        //[System.Web.Mvc.Authorize]
        //public ViewResult Index()
        //{
        //    ViewBag.Message = "Welcome to LegoList";

        //    return View();

        //}

        [System.Web.Mvc.Authorize]
        public ActionResult Index()
        {
            ViewBag.Message = "Modify this template to jump-start your ASP.NET MVC application.";

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult TestSR()
        {
            ViewBag.Message = "SignalR Test";

            return View();
        }

        void SendMessage()
        {
            var MyMessage = "The time is now!  " + DateTime.Now.ToShortTimeString();
            var context = GlobalHost.ConnectionManager.GetConnectionContext<LegoListEndPoint>();

            context.Connection.Broadcast(MyMessage);
        }
    }
}
