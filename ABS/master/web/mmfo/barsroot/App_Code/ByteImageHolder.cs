using Bars.UserControls;
using System;
using System.Web.SessionState;

namespace Bars.Utils
{
    public static class ByteImageHolder
    {
        public static ByteData GetImageByteDataFromSession(HttpSessionState session, string imageDataSessionID)
        {
            if (session[imageDataSessionID] == null)
            {
                string path = System.IO.Path.Combine(System.IO.Path.GetTempPath(), imageDataSessionID);
                if (!System.IO.File.Exists(path))
                {
                    return null;
                }
                byte[] f = System.IO.File.ReadAllBytes(path);       // try read data from disc ... bad-bad-bad...
                session[imageDataSessionID] = new ByteData(f);
            }

            return (ByteData)session[imageDataSessionID];
        }

        public static byte[] GetImageFromSession(HttpSessionState session, string imageDataSessionID)
        {
            using (ByteData d = GetImageByteDataFromSession(session, imageDataSessionID)) 
                return d != null ? d.Data : null;
        }

        public static void SetImageIntoSession(HttpSessionState session, string imageDataSessionID, ByteData data)
        {
            if (data == null)
                session.Remove(imageDataSessionID);
            else
                session[imageDataSessionID] = data;
        }

        public static void SetImageIntoSession(HttpSessionState session, string imageDataSessionID, byte[] data)
        {
            if (data == null)
                return;

            if (session[imageDataSessionID] != null)
            {
                (session[imageDataSessionID] as ByteData).Dispose();
                session[imageDataSessionID] = null;
            }

            session[imageDataSessionID] = new ByteData(data);
        }

        public static bool IsImageInSession(HttpSessionState session, string imageDataSessionID)
        {
            bool hasValue = session[imageDataSessionID] != null && ((ByteData)session[imageDataSessionID]).HasData;
            if (!hasValue)
            {
                string path = System.IO.Path.Combine(System.IO.Path.GetTempPath(), imageDataSessionID);
                hasValue = System.IO.File.Exists(path);
            }

            return hasValue;
        }
    }
}
