using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LegoList.Models
{
    public enum SatisfactionLevel { Low, Medium, High };

    public class LegoProduct
    {
        public int Id {get ;set ;}
        public string Description { get; set; }
        public string ProductId { get; set; }
        public DateTime DatePurchased { get; set; }
        public SatisfactionLevel SatisfactionLevel { get; set; }
    }
}