using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// класс адреса
    public struct CustomerAddress
    {
        public int TYPE_ID { get; set; }            //Тип адреса (1 Юридична, 2 Фактична,3  Почтова)
        public int COUNTRY { get; set; }            //Код страны
        public int ZIP { get; set; }                //Индекс
        public string DOMAIN { get; set; }          //Область
        public string REGION { get; set; }          //Регион
        public string LOCALITY { get; set; }        //Населенный пункт
        public string ADDRESS { get; set; }         //Адрес (улица, дом, квартира) - это составное поле из остальных!
        public int TERRITORY_ID { get; set; }       //Код адреса
        public int LOCALITY_TYPE { get; set; }      //Тип населенного пункта
        public int STREET_TYPE { get; set; }        //Тип улицы
        public string STREET { get; set; }          //Улица
        public int HOME_TYPE { get; set; }          //Тип дома
        public string HOME { get; set; }            //№ дома
        public int HOMEPART_TYPE { get; set; }      //Тип деления дома(если есть)
        public string HOMEPART { get; set; }        //№ типа деления дома
        public int ROOM_TYPE { get; set; }          //Тип жилого помещения
        public string ROOM { get; set; }            //№ жилого помещения
        public string COMM { get; set; }            //Довільний коментар    
    }
}