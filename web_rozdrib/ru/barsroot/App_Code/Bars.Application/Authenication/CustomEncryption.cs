using System;
using System.Security.Cryptography;
using System.Text;

namespace Bars.Application
{
	public sealed class CustomEncryption
	{
		private static string key = "sfdjf48mdfdf3054";

		public CustomEncryption()
		{
		}

		public static string Encrypt(String plainText )
		{
			string encrypted = null;
			try
			{
                byte[] inputBytes = ASCIIEncoding.UTF8.GetBytes(plainText);
				byte[] pwdhash = null;
				MD5CryptoServiceProvider hashmd5;

				hashmd5 = new MD5CryptoServiceProvider();
                pwdhash = hashmd5.ComputeHash(ASCIIEncoding.UTF8.GetBytes(key));
				hashmd5 = null;

				TripleDESCryptoServiceProvider tdesProvider = new TripleDESCryptoServiceProvider();
				tdesProvider.Key = pwdhash;
				tdesProvider.Mode = CipherMode.ECB;

				encrypted = Convert.ToBase64String(
					tdesProvider.CreateEncryptor().TransformFinalBlock(inputBytes, 0, inputBytes.Length));
			}
            catch (System.Exception e)
			{
                string str = e.Message;
				throw ;
			}
			return encrypted;
		}

		public static String Decrypt(string encryptedString)
		{
			string decyprted = null;
			byte[] inputBytes = null;

			try
			{
				inputBytes = Convert.FromBase64String(encryptedString);
				byte[] pwdhash = null;
				MD5CryptoServiceProvider hashmd5;

				hashmd5 = new MD5CryptoServiceProvider();
                pwdhash = hashmd5.ComputeHash(ASCIIEncoding.UTF8.GetBytes(key));
				hashmd5 = null;

                TripleDESCryptoServiceProvider tdesProvider = new TripleDESCryptoServiceProvider();
				tdesProvider.Key = pwdhash;
				tdesProvider.Mode = CipherMode.ECB;

                decyprted = ASCIIEncoding.UTF8.GetString(
					tdesProvider.CreateDecryptor().TransformFinalBlock(inputBytes, 0, inputBytes.Length));
			}
            catch (System.Exception e)
			{
				string str = e.Message;
				throw ;
			}
			return decyprted;
		}

        public static string GetSHA1Hash(string source)
        {
            SHA1 sha = new SHA1CryptoServiceProvider();
            byte[] result = sha.ComputeHash(ASCIIEncoding.UTF8.GetBytes(source));
            return BitConverter.ToString(result).Replace("-", "").ToLower();
        }
	}
}
