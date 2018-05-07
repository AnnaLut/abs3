using System;
using System.Security.Cryptography;
using System.Text;

namespace BarsWeb.Core.Infrastructure.Helpers
{
	public sealed class EncryptionHelper : IEncryptionHelper
	{
	    private const string key = "sfdjf48mdfdf3054";
	    public string Encrypt(string plainText)
	    {
	        byte[] inputBytes = ASCIIEncoding.UTF8.GetBytes(plainText);

	        var hashmd5 = new MD5CryptoServiceProvider();
	        var pwdhash = hashmd5.ComputeHash(ASCIIEncoding.UTF8.GetBytes(key));
	        hashmd5 = null;

	        TripleDESCryptoServiceProvider tdesProvider = new TripleDESCryptoServiceProvider
	        {
	            Key = pwdhash,
	            Mode = CipherMode.ECB
	        };

	        var encrypted = Convert.ToBase64String(
	            tdesProvider.CreateEncryptor().TransformFinalBlock(inputBytes, 0, inputBytes.Length));

	        return encrypted;
	    }

	    public string Decrypt(string encryptedString)
	    {
	        string decyprted;

	        var inputBytes = Convert.FromBase64String(encryptedString);
	        byte[] pwdhash = null;

	        var hashmd5 = new MD5CryptoServiceProvider();
	        pwdhash = hashmd5.ComputeHash(ASCIIEncoding.UTF8.GetBytes(key));
	        hashmd5 = null;

	        TripleDESCryptoServiceProvider tdesProvider = new TripleDESCryptoServiceProvider
	        {
	            Key = pwdhash,
	            Mode = CipherMode.ECB
	        };

	        decyprted = ASCIIEncoding.UTF8.GetString(
	            tdesProvider.CreateDecryptor().TransformFinalBlock(inputBytes, 0, inputBytes.Length));
	        return decyprted;
	    }

	    public string GetSha1Hash(string source)
        {
            SHA1 sha = new SHA1CryptoServiceProvider();
            byte[] result = sha.ComputeHash(ASCIIEncoding.UTF8.GetBytes(source));
            return BitConverter.ToString(result).Replace("-", "").ToLower();
        }
	}

    public interface IEncryptionHelper
    {
        string Encrypt(string plainText);
        string Decrypt(string encryptedString);
        string GetSha1Hash(string source);
    }
}
