using System;
namespace clientregister
{
	public class CustomerAddress
	{
		public class Address
		{
			public Boolean filled = false;
			public String zip;
			public String domain;
			public String region;
			public String locality;
			public String address;
			public Decimal? territory_id;
			public Decimal? locality_type;
			public Decimal? street_type;
			public String street;
			public Decimal? home_type;
			public String home;
			public Decimal? homepart_type;
			public String homepart;
			public Decimal? room_type;
			public String room;
			public string Comment;
            public decimal? region_id;
            public decimal? area_id;
            public decimal? settlement_id;
            public decimal? street_id;
            public decimal? house_id;
            public string region_name;
            public string area_name;
            public string settlement_name;
            public string street_name;
            public string house_num;
            public decimal? settlement_tp_id;
            public string settlement_tp_nm;
            public decimal? str_tp_id;
            public string str_tp_nm;
            public decimal? aht_tp_id;
            public string aht_tp_value;
            public decimal? ahpt_tp_id;
            public string ahpt_tp_value;
            public decimal? art_tp_id;
            public string art_tp_value;

            public Address() : this("", "", "", "", "", null, null, null, "", null, "", null, "", null, "", "", null, null, null, null, null, "", "", "", "", "", null, "", null, "", null, "", null, "", null, "")
            {
            }
			public Address(String zip,
							String domain,
							String region,
							String locality,
							String address,
							Decimal? territory_id,
							Decimal? locality_type,
							Decimal? street_type,
							String street,
							Decimal? home_type,
							String home,
							Decimal? homepart_type,
							String homepart,
							Decimal? room_type,
							String room,
							string comment,
                            decimal? region_id,
                            decimal? area_id,
                            decimal? settlement_id,
                            decimal? street_id,
                            decimal? house_id,
                            string region_name,
                            string area_name,
                            string settlement_name,
                            string street_name,
                            string house_num,
                            decimal? settlement_tp_id,
                            string settlement_tp_nm,
                            decimal? str_tp_id,
                            string str_tp_nm,
                            decimal? aht_tp_id,
                            string aht_tp_value,
                            decimal? ahpt_tp_id,
                            string ahpt_tp_value,
                            decimal? art_tp_id,
                            string art_tp_value)
			{
				this.filled = true;
				this.zip = zip;
				this.domain = domain;
				this.region = region;
				this.locality = locality;
				this.address = address;
				this.territory_id = territory_id;


				this.locality_type = locality_type;
				this.street_type = street_type;
				this.street = street;
				this.home_type = home_type;
				this.home = home;
				this.homepart_type = homepart_type;
				this.homepart = homepart;
				this.room_type = room_type;
				this.room = room;
				this.Comment = comment;
                this.region_id = region_id;
                this.area_id = area_id;
                this.settlement_id = settlement_id;
                this.street_id = street_id;
                this.house_id = house_id;
                this.region_name = region_name;
                this.area_name = area_name;
                this.settlement_name = settlement_name;
                this.street_name = street_name;
                this.house_num = house_num;
                this.settlement_tp_id = settlement_tp_id;
                this.settlement_tp_nm = settlement_tp_nm;
                this.str_tp_id = str_tp_id;
                this.str_tp_nm = str_tp_nm;
                this.aht_tp_id = aht_tp_id;
                this.aht_tp_value = aht_tp_value;
                this.ahpt_tp_id = ahpt_tp_id;
                this.ahpt_tp_value = ahpt_tp_value;
                this.art_tp_id = art_tp_id;
                this.art_tp_value = art_tp_value;
            }
		}

		public Address type1;
		public Address type2;
		public Address type3;

		public CustomerAddress()
		{
			type1 = new Address();
			type2 = new Address();
			type3 = new Address();
		}
	}
}