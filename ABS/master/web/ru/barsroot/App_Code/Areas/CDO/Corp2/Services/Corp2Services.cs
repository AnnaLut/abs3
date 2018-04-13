using BarsWeb.Areas.CDO.Common.Repository;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
namespace BarsWeb.Areas.CDO.Corp2.Services
{
    /// <summary>
    /// Summary description for Corp2Services
    /// </summary>
    public class Corp2Services : ICorp2Services
    {
        private byte[] _symKey;
        private byte[] _symIv;
        private readonly string appName = "ABS";
        private IParametersRepository parametersRepository;
        private UserManagerService userManager;
        private CustomerManagerService customerManager;
        private SecretService secretService;
        private readonly string url;
        private readonly string userManagerServiceName = "UserManagerService.asmx";
        private readonly string customerManagerServiceName = "CustomerManagerService.asmx";
        private readonly string secretServiceName = "SecretService.asmx";
        public Corp2Services(IParametersRepository parametersRepository)
        {
            this.parametersRepository = parametersRepository;

            url = GetUrl();

            secretService = new SecretService();
            secretService.Url = url + secretServiceName;
        }
        public UserManagerService UserManager
        {
            get
            {
                if (userManager == null)
                {
                    userManager = new UserManagerService();
                    userManager.Url = url  + userManagerServiceName;
                }
                return userManager;
            }
        }
        public CustomerManagerService CustomerManager
        {
            get
            {
                if (customerManager == null)
                {
                    customerManager = new CustomerManagerService();
                    customerManager.Url = url + customerManagerServiceName;
                }
                return customerManager;
            }
        }
        private string GetUrl()
        {
            var parameters = parametersRepository.GetAll().ToList();
            var baseApiUrl = parameters.FirstOrDefault(i => i.Name == "Corp2.BaseApiUrl");
            if (baseApiUrl == null)
            {
                throw new Exception("Parameter Corp2.BaseApiUrl is null in MBM_PARAMETERS");
            }
            return baseApiUrl.Value;
        }
        public string GetSecretKey()
        {
            string toHash = appName + "|" + secretService.GetToken();
            string key = Encrypt(toHash) + "|" + appName;
            return key;
        }
        private string Encrypt(string valueToEncrypt)
        {
            // Declare the stream used to encrypt to an in memory array of bytes.
            // and create the streams used for encryption.
            using (var msEncrypt = new MemoryStream())
            {
                using (var cryptoProvider = new RijndaelManaged())
                {
                    //Generate Key and Vector
                    _symKey = new byte[16];
                    _symIv = new byte[16];

                    GenerateKeyVector(valueToEncrypt);
                    //Limit the size to 128 bit, this can be increased to 192 or 256 to improve
                    //the strength of encryption
                    cryptoProvider.KeySize = 128;
                    cryptoProvider.Key = _symKey;
                    cryptoProvider.IV = _symIv;

                    // Create a decrytor to perform the stream transform.
                    using (var cryptoTrans = cryptoProvider.CreateEncryptor(cryptoProvider.Key, cryptoProvider.IV))
                    {
                        using (var cryptoStreamEncr = new CryptoStream(msEncrypt, cryptoTrans, CryptoStreamMode.Write))
                        {
                            var arrayInput = Encoding.UTF8.GetBytes(valueToEncrypt);
                            cryptoStreamEncr.Write(arrayInput, 0, arrayInput.Length);
                            cryptoStreamEncr.Flush();
                        }
                    }
                    //Return encrypted string in Base64 format
                    return Convert.ToBase64String(msEncrypt.ToArray());
                }
            }
        }
        /// <summary>
        ///     Generates a key and vector based on the Hash algorithm in SHA256Managed. Basically it takes an
        ///     string and generates a 256 bit hash value for that.
        /// </summary>
        /// <param name="inputValue">String symmetric key</param>
        /// <returns>None</returns>
        private void GenerateKeyVector(string inputValue)
        {
            var keyValue = Encoding.UTF8.GetBytes(inputValue); //Byte Key
            using (SHA256 hashMgr = new SHA256Managed())
            {
                //Generate the hashed key- 256 bits/ 32 bytes
                var resultValue = hashMgr.ComputeHash(keyValue); // Result Key- contains the hash value of actual key
                //clear resources
                hashMgr.Clear();

                //now Initialize the 'Key' array with the lower 16 bytes/128 bits of the
                //Hash of the 'key' string provided
                int iIdx; // Indexer
                for (iIdx = 0; iIdx < 16; iIdx++)
                {
                    _symKey[iIdx] = resultValue[iIdx];
                }
                //Initialize the 'Vector' array with the upper 16 Bytes/128 bits of
                //Hash result
                for (iIdx = 16; iIdx < 32; iIdx++)
                {
                    _symIv[iIdx - 16] = resultValue[iIdx];
                }
            }
        }
    }

    public interface ICorp2Services
    {
        UserManagerService UserManager { get; }
        CustomerManagerService CustomerManager { get; }
        string GetSecretKey();
    }
}