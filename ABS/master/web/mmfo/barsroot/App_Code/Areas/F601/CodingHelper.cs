using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BarsWeb.Areas.F601.Helpers
{
    public static class CodingHelper
    {
        public static string EncodeStringToBase64UrlString(string inText)
        {
            byte[] arrText = Encoding.UTF8.GetBytes(inText);
            return EncodeByteArrToBase64UrlString(arrText);
        }

        public static string EncodeByteArrToBase64UrlString(byte[] byteArr)
        {
            string base64String = Convert.ToBase64String(byteArr);
            base64String = base64String.Replace('+', '-');
            base64String = base64String.Replace('/', '_');
            base64String = base64String.Split('=')[0];

            return base64String;
        }

        public static string DecodeBase64UrlStringToString(string inBase64URLString)
        {
            byte[] arrText = DecodeBase64UrlStringToByteArray(inBase64URLString);
            return Encoding.UTF8.GetString(arrText);
        }

        public static byte[] DecodeBase64UrlStringToByteArray(string inBase64URLString)
        {
            string base64Text = inBase64URLString.Replace('-', '+');
            base64Text = base64Text.Replace('_', '/');

            switch (base64Text.Length % 4)
            {
                case 0:
                    break;
                case 2:
                    base64Text += "==";
                    break;
                case 3:
                    base64Text += "=";
                    break;
                default:
                    throw new Exception("Invalid base64 string length! ");
            }

            return Convert.FromBase64String(base64Text);
        }

        public static byte[] ConvertHexStringToByteArray(string hexString)
        {
            var bytes = new byte[hexString.Length / 2];
            for (var i = 0; i < bytes.Length; i++)
            {
                bytes[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);
            }
            return bytes;
        }
    }
}
