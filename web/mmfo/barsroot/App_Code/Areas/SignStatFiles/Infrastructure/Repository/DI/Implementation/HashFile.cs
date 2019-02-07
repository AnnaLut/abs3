using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;

namespace BarsWeb.Areas.SignStatFiles.Infrastructure.DI.Implementation
{
    public static class HashFile
    {
        public const String title = "vega2";
        public const uint CRYPT_VERIFYCONTEXT = 0xF0000000; //no private key access required
        public const uint ALG_SID_G34311 = 81;

        /*//------------------------------------------------------------------------------
        // ГОСТ 34311
        //------------------------------------------------------------------------------
        #define CALG_G34311             (ALG_CLASS_HASH|ALG_TYPE_ANY|ALG_SID_G34311)
        #define CALG_G34311_BITS         256
        #define CALG_G34311_HASH_SIZE    32*/

        public const Int32 CALG_G34311 = (4 << 13) | 81;
        public const Int32 HP_HASHSIZE = 0x00000004;
        public const Int32 HP_HASHVAL = 0x00000002;

        //На вході: stream від файлу. 
        //На виході: Обчислене значення геш-суми файлу за алгоритмом ГОСТ 34.311-95 у формі текстовий HEX
        public static string Gost34311Hash(Stream fileStream)
        {
            const string VEGA_DSTU_PROV_NAME = "Vega DSTU Cryptographic Provider";
            const uint VEGA_DSTU_PROV_TYPE = 81;

            String provider = VEGA_DSTU_PROV_NAME;
            String container = null;
            uint type = VEGA_DSTU_PROV_TYPE;
            uint cspflags = CRYPT_VERIFYCONTEXT; //no private key access required.
            IntPtr hProv = IntPtr.Zero;

            bool retVal = false;

            retVal = Win32.CryptAcquireContext(ref hProv, container, provider, type, cspflags);
            if (!retVal)
            {
                showWin32Error(Marshal.GetLastWin32Error());
                return null;
            }

            IntPtr hHash = new IntPtr();
            if (!Win32.CryptCreateHash(
                hProv,
                CALG_G34311,
                IntPtr.Zero,
                0,
                ref hHash))
            {
                showWin32Error(Marshal.GetLastWin32Error());
                return null;
            }

            byte[] data = new byte[1024];
            int dataLen = data.Length;

            using (Stream source = fileStream)
            {
                int bytesRead = 0;
                while ((bytesRead = source.Read(data, 0, dataLen)) > 0)
                {
                    retVal = Win32.CryptHashData(hHash, data, bytesRead, 0);
                }
            }

            int bufferLen = 32; // hash size
            byte[] buffer = new byte[bufferLen];

            retVal = Win32.CryptGetHashParam(hHash, HP_HASHVAL, buffer, ref bufferLen, 0);
            retVal = Win32.CryptDestroyHash(hHash);

            if (hProv != IntPtr.Zero)
                retVal = Win32.CryptReleaseContext(hProv, 0);

            //string dataDigest = Convert.ToBase64String(buffer, 0, buffer.Length);
            //return dataDigest;

            StringBuilder sb = new StringBuilder();
            foreach (byte b in buffer)
                sb.Append(b.ToString("X2"));

            string hexString = sb.ToString();
            return hexString;

        }

        private static void showWin32Error(int errorcode)
        {
            Win32Exception myEx = new Win32Exception(errorcode);
            Console.WriteLine("Error code:\t 0x{0:X}", myEx.ErrorCode);
            Console.WriteLine("Error message:\t " + myEx.Message);
        }

    }

    public static class Win32
    {
        [DllImport("advapi32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern bool CryptAcquireContext(
          ref IntPtr hProv,
          string pszContainer,
          string pszProvider,
          uint dwProvType,
          uint dwFlags);

        [DllImport("advapi32.dll", SetLastError = true)]
        public static extern bool CryptReleaseContext(
          IntPtr hProv,
          uint dwFlags);


        /*BOOL WINAPI CryptGetProvParam(
          HCRYPTPROV hProv,
          DWORD dwParam,
          BYTE* pbData,
          DWORD* pdwDataLen,
          DWORD dwFlags
        );
        */

        [DllImport("advapi32.dll", SetLastError = true)]
        public static extern bool CryptGetProvParam(
          IntPtr hProv,
          uint dwParam,
          [In, Out] byte[] pbData,
          ref uint dwDataLen,
          uint dwFlags);

        [DllImport("advapi32.dll", SetLastError = true)]
        public static extern bool CryptGetProvParam(
          IntPtr hProv,
          uint dwParam,
          [MarshalAs(UnmanagedType.LPStr)] StringBuilder pbData,
          ref uint dwDataLen,
          uint dwFlags);

        [DllImport("advapi32.dll", SetLastError = true)]
        public static extern bool CryptCreateHash(
            IntPtr hProv,
            Int32 Algid,
            IntPtr hKey,
            Int32 dwFlags,
            ref IntPtr phHash
        );

        [DllImport("advapi32.dll", SetLastError = true)]
        public static extern Boolean CryptHashData(
            IntPtr hHash,
            Byte[] pbData,
            Int32 dwDataLen,
            Int32 dwFlags
        );

        [DllImport("advapi32.dll", SetLastError = true)]
        public static extern bool CryptGetHashParam(
               IntPtr hHash,
               Int32 dwParam,
               Byte[] pbData,
               ref Int32 pdwDataLen,
               Int32 dwFlags
        );

        [DllImport("advapi32.dll", SetLastError = true)]
        public static extern bool CryptDestroyHash(
            IntPtr hHash
        );

    }
}
