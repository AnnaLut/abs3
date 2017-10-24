using System.Xml.Serialization;

/// <summary>
/// Summary description for SimpleRequest
/// </summary>
namespace BarsWeb.Areas.Pfu.Models.ApiModels
{
    [XmlRoot(ElementName = "request")]
    public class SimpleRequest
    {
        /// <summary>
        /// версія транспортного конверту (поточний документ описує версію 0001);
        /// </summary>
        [XmlElement("ver")]
        public string Ver { get; set; }

        /// <summary>
        /// код запиту до програмного комплексу ПФУ
        /// </summary>
        [XmlElement("code")]
        public string Code { get; set; }

        /// <summary>
        /// ідентифікатор запиту з прикладної системи
        /// </summary>
        [XmlElement("num")]
        public string Num { get; set; }

        /// <summary>
        /// ідентифікатор запитувача в програмного комплексу ПФУ
        /// </summary>
        [XmlElement("from")]
        public string From { get; set; }

        /// <summary>
        /// ідентифікатор провайдера запиту
        /// </summary>
        [XmlElement("to")]
        public string To { get; set; }

        /// <summary>
        /// електронно-цифровий підпис на дані запиту. Інформаційний об’єкт для обчислення ЕЦП визначається за формулою: VER + '#' + CODE + '#' + NUM + '#' + FROM + '#' + TO + '#' + DATA (формула записана на C#). Для обчислення ЕЦП використовується функція RawSignData модуля криптографічних перетворень IIT
        /// </summary>
        [XmlElement("ecp")]
        public string Ecp { get; set; }

        /// <summary>
        /// дані запиту, зашифровані за допомогою функції EnvelopDataToRecipients (версія функції, яка приймає масив байт – byte[]) модуля криптографічних перетворень IIT. Дані на шифрування передаються в base64-кодуванні
        /// </summary>
        [XmlElement("data")]
        public string Data { get; set; }

        /// <summary>
        /// поле формується підчас реєстрації запиту в програмний комплекс ПФУ і містить код помилки. Якщо реєстрація запита успішна (формат, ЕЦП, шифрування – успішні), тоді ECODE дорівнює «0»
        /// </summary>
        [XmlElement("ecode")]
        public string Ecode { get; set; }

        /// <summary>
        /// при ECODE≠0 містить діагностичне повідомлення
        /// </summary>
        [XmlElement("emessage")]
        public string Emessage { get; set; }
    }
}