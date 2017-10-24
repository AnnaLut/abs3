using System;
using System.Text;
using System.IO;
using System.Data;
using System.Security.Cryptography;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Bars.Encryption
{
    /// <summary>
    /// Класс реализации RC4 шифрования
    /// </summary>
    public class RC4Crypto
    {
        private string p_key = "test key";
        /// <summary>
        // Конструктор класса 
        /// </summary>
        /// <param name="key">значение ключа шифрования</param>
        public RC4Crypto(string key)
        {
            this.p_key = key;
        }
        /// <summary>
        /// зашифровать строку
        /// </summary>
        /// <param name="source">входящая строка</param>
        /// <returns>шифрованая строка в base64</returns>
        public string Encrypt(string source)
        {
            return StringHelper.StrToBase64(rc4crypt(this.p_key, source));
        }
        //
        /// <summary>
        /// расшифровать строку
        /// </summary>
        /// <param name="source">входящая шифрованая строка в base64</param>
        /// <returns>расшифрованая строка</returns>
        public string Decrypt(string source)
        {
            return rc4crypt(this.p_key, StringHelper.FromBase64ToStr(source));
        }

        //базовый метод шифрования
        private string rc4crypt(string key, string str)
        {
            byte[] s = new byte[256];
            int i = 0;
            int j = 0;
            for (i = 0; i < 256; i++)
                s[i] = (byte)i;

            byte x;
            for (i = 0; i < 256; i++)
            {
                j = (j + s[i] + key[i % key.Length]) % 256;
                x = s[i];
                s[i] = s[j];
                s[j] = x;
            }
            i = 0;
            j = 0;
            string ct = "";
            for (int y = 0; y < str.Length; y++)
            {
                i = (i + 1) % 256;
                j = (j + s[i]) % 256;
                x = s[i];
                s[i] = s[j];
                s[j] = x;
                ct += new string(new char[] { (char)(str[y] ^ s[(s[i] + s[j]) % 256]) });
            }
            return ct;//Convert.ToBase64String(Encoding.UTF8.GetBytes(ct));
        }

    }
    
    
    
    /// <summary>
    /// Класс реализации RSA шифрования
    /// </summary>
    public class RSACrypto
    {
        private RSACryptoServiceProvider _sp;

        public RSAParameters ExportParameters(bool includePrivateParameters)
        {
            return _sp.ExportParameters(includePrivateParameters);
        }

        public void InitCrypto()
        {
            getInitXml();
            _sp = new RSACryptoServiceProvider();
            _sp.FromXmlString((string)System.Web.HttpContext.Current.Session["InitXml"]);
        }

        private void getInitXml()
        {
            if (System.Web.HttpContext.Current.Session["InitXml"] == null)
            {
                int keySize = 1024;
                RSACryptoServiceProvider sp = new RSACryptoServiceProvider(keySize);
                System.Web.HttpContext.Current.Session["InitXml"] = sp.ToXmlString(true);
            }
        }

        public byte[] Encrypt(string txt)
        {
            byte[] result;

            ASCIIEncoding enc = new ASCIIEncoding();
            int numOfChars = enc.GetByteCount(txt);
            byte[] tempArray = enc.GetBytes(txt);
            result = _sp.Encrypt(tempArray, false);

            return result;
        }

        public byte[] Decrypt(byte[] txt)
        {
            byte[] result;

            result = _sp.Decrypt(txt, false);

            return result;
        }
    }

    /// <summary>
    /// Класс работы со строками для шифрования
    /// </summary>
    public class StringHelper
    {
        public static byte[] HexStringToBytes(string hex)
        {
            if (hex.Length == 0)
            {
                return new byte[] { 0 };
            }

            if (hex.Length % 2 == 1)
            {
                hex = "0" + hex;
            }

            byte[] result = new byte[hex.Length / 2];

            for (int i = 0; i < hex.Length / 2; i++)
            {
                result[i] = byte.Parse(hex.Substring(2 * i, 2), System.Globalization.NumberStyles.AllowHexSpecifier);
            }

            return result;
        }

        public static string BytesToHexString(byte[] input)
        {
            StringBuilder hexString = new StringBuilder(64);

            for (int i = 0; i < input.Length; i++)
            {
                hexString.Append(String.Format("{0:X2}", input[i]));
            }
            return hexString.ToString();
        }

        public static string BytesToDecString(byte[] input)
        {
            StringBuilder decString = new StringBuilder(64);

            for (int i = 0; i < input.Length; i++)
            {
                decString.Append(String.Format(i == 0 ? "{0:D3}" : "-{0:D3}", input[i]));
            }
            return decString.ToString();
        }

        // Bytes are string
        public static string ASCIIBytesToString(byte[] input)
        {
            System.Text.ASCIIEncoding enc = new ASCIIEncoding();
            return enc.GetString(input);
        }
        public static string UTF16BytesToString(byte[] input)
        {
            System.Text.UnicodeEncoding enc = new UnicodeEncoding();
            return enc.GetString(input);
        }
        public static string UTF8BytesToString(byte[] input)
        {
            System.Text.UTF8Encoding enc = new UTF8Encoding();
            return enc.GetString(input);
        }

        // Преобразовать масив байтов в строку в base64 кодировке
        public static string ToBase64(byte[] input)
        {
            return Convert.ToBase64String(input);
        }
        // Преобразовать строку в строку в base64 кодировке
        public static string StrToBase64(string str)
        {
            return Convert.ToBase64String(Encoding.UTF8.GetBytes(str));
        }
        // Преобразовать строку в base64 кодировке в масив байтов 
        public static byte[] FromBase64(string base64)
        {
            return Convert.FromBase64String(base64);
        }
        public static string FromBase64ToStr(string base64)
        {
            return Encoding.UTF8.GetString(Convert.FromBase64String(base64));
        }

        public static string ConvertEncoding(string value, Encoding src, Encoding trg)
        {
            byte[] srcBytes = trg.GetBytes(value);
            byte[] dstBytes = Encoding.Convert(src, trg, srcBytes);

            return trg.GetString(dstBytes);
        }
    }
}
