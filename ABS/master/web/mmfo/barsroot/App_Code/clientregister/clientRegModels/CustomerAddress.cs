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

			public Address() : this("", "", "", "", "", null, null, null, "", null, "", null, "", null, "", "")
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
							string comment)
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