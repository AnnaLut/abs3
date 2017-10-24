using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Areas.AccessToAccounts.Models
{
    public class  UserUpdate
    {
        public decimal GroupID { get; set; }
        public decimal UserID { get; set; }
        public decimal canView { get; set; }
        public decimal canCredit { get; set; }
        public decimal canDebit { get; set; }
    }

    //public class ListUserUpdates
    //{
    //    public decimal ID { get; set; }

    //    public List<UserUpdate> UserUpdate { get; set; }


    //}

}