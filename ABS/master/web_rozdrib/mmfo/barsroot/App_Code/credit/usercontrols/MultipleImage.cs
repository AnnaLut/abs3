using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

namespace Bars.UserControls
{
    public class MultipleImage : IDisposable
    {
        # region Приватные свойства
        private bool isDisposed = false;
        private List<String> _Images;
        private String _MtplImage;
        private String MtplImage
        {
            get
            {
                if (String.IsNullOrEmpty(_MtplImage)) _MtplImage = this.GetImgPath();
                return _MtplImage;
            }
        }
        private static String WcsScansPath
        {
            get
            {
                return Path.GetTempPath() + "WcsScans/";
            }
        }
        # endregion

        # region Публичные свойства
        public int ImgCount
        {
            get
            {
                return _Images.Count;
            }
        }
        # endregion

        # region Публичные методы
        public Byte[] GetMultipleImage()
        {
            // если картинок нет тоничего не возвращаем
            if (!File.Exists(MtplImage)) return null;

            Bitmap bmp = new Bitmap(MtplImage);
            MemoryStream ms = new MemoryStream();

            bmp.Save(ms, ImageFormat.Jpeg);

            Byte[] msArray = ms.ToArray();

            // чистим память
            bmp.Dispose();
            ms.Dispose();

            return msArray;
        }
        public void AddImage(Byte[] img)
        {
            if (img == null) return;

            Bitmap BitmapImage = new Bitmap(new System.IO.MemoryStream(img));

            // информация о кол-ве картинок
            Int32 ImgCnt = 1;
            if (ContainsViaForLoop((BitmapImage as System.Drawing.Image).PropertyIdList, 1))
            {
                ImgCnt = BitConverter.ToInt32((BitmapImage as System.Drawing.Image).GetPropertyItem(1).Value, 0);
                HttpContext.Current.Trace.Write("Картинок - " + ImgCnt);
            }

            // поочередно достаем картинки
            Int32 CurX = 0;
            Int32 CurY = 0;
            for (int i = 1; i <= ImgCnt; i++)
            {
                Int32 ImgW = BitmapImage.Width;
                Int32 ImgH = BitmapImage.Height;

                if (ContainsViaForLoop((BitmapImage as System.Drawing.Image).PropertyIdList, i * 10 + 0)
                    && ContainsViaForLoop((BitmapImage as System.Drawing.Image).PropertyIdList, i * 10 + 1))
                {
                    ImgW = BitConverter.ToInt32((BitmapImage as System.Drawing.Image).GetPropertyItem(i * 10 + 0).Value, 0);
                    ImgH = BitConverter.ToInt32((BitmapImage as System.Drawing.Image).GetPropertyItem(i * 10 + 1).Value, 0);
                }

                HttpContext.Current.Trace.Write("Картинка " + i.ToString() + ": " + ImgW.ToString() + " " + ImgH.ToString());

                Bitmap BitmapSubImage = new Bitmap(ImgW, ImgH);
                Graphics g = Graphics.FromImage(BitmapSubImage);
                g.DrawImage(BitmapImage, new Rectangle(0, 0, ImgW, ImgH), new Rectangle(CurX, CurY, ImgW, ImgH), GraphicsUnit.Pixel);

                CurY += ImgH;

                String Img = GetImgPath();
                BitmapSubImage.Save(Img, System.Drawing.Imaging.ImageFormat.Jpeg);
                _Images.Add(Img);

                // чистим память
                BitmapSubImage.Dispose();
                g.Dispose();
            }

            // создаем общую картинку
            MakeMultipleImage();
        }
        public Byte[] GetImage(int i)
        {
            if (i >= _Images.Count) return null;

            Bitmap bmp = new Bitmap(_Images[i]);
            MemoryStream ms = new MemoryStream();

            bmp.Save(ms, ImageFormat.Jpeg);

            Byte[] msArray = ms.ToArray();

            // чистим память
            bmp.Dispose();
            ms.Dispose();

            return msArray;
        }
        public void RemoveImage(int i)
        {
            if (i >= _Images.Count) return;

            File.Delete(_Images[i]);
            _Images.RemoveAt(i);

            MakeMultipleImage();
        }
        public void RemoveLast()
        {
            RemoveImage(_Images.Count - 1);
        }
        public void RemoveAll()
        {
            int cnt = _Images.Count;
            for (int i = 0; i < cnt; i++)
                RemoveLast();
        }

        public static void ClearSessionScans(System.Web.SessionState.HttpSessionState Session)
        {
            String Prefix1 = "IMAGE_DATA_";
            String Prefix2 = "SCANER_DATA_";

            System.Collections.ArrayList SessionKeys = new System.Collections.ArrayList(Session.Keys);
            for (int i = 0; i < SessionKeys.Count; i++)
            {
                String key = (String)SessionKeys[i];
                if (key.StartsWith(Prefix1) || key.StartsWith(Prefix2))
                {
                    Object obj = Session[key];
                    if (obj is IDisposable)
                        (obj as IDisposable).Dispose();
                    Session.Remove(key);
                }
            }

        }
        public static void ClearScansFolder()
        {
            String[] Files = System.IO.Directory.GetFiles(WcsScansPath);
            foreach (String File in Files)
                System.IO.File.Delete(File);
        }
        # endregion

        # region Приватные методы
        private Boolean ContainsViaForLoop(int[] data, int value)
        {
            for (int i = 0; i < data.Length; i++)
            {
                if (data[i] == value)
                {
                    return true;
                }
            }
            return false;
        }
        private String GetFolderPath()
        {
            if (!Directory.Exists(WcsScansPath)) Directory.CreateDirectory(WcsScansPath);
            return WcsScansPath + "scan_" + Path.GetRandomFileName();
        }
        private String GetImgPath()
        {
            String WcsScansFolder = Path.GetTempPath() + "WcsScans/";
            if (!Directory.Exists(WcsScansFolder)) Directory.CreateDirectory(WcsScansFolder);
            return WcsScansFolder + "scan_" + Path.GetRandomFileName();
        }
        private void MakeMultipleImage()
        {
            // если картинок нет тоничего не возвращаем
            if (_Images.Count == 0)
            {
                if (File.Exists(MtplImage)) File.Delete(MtplImage);
                return;
            }

            // переводим все картинки в бинтмап
            List<Bitmap> BitmapImages = new List<Bitmap>();
            foreach (String Img in _Images)
            {
                Bitmap BitmapImage = new Bitmap(Img);
                BitmapImages.Add(BitmapImage);
            }

            // Определяем размеры результирующей картинки
            Int32 TotalWidth = 0;
            Int32 TotalHeight = 0;
            foreach (Bitmap bm in BitmapImages)
            {
                TotalWidth = Math.Max(TotalWidth, bm.Width);
                TotalHeight += bm.Height;
            }

            // результирующий объект
            Bitmap MultipleImage = new Bitmap(TotalWidth, TotalHeight);
            Graphics g = Graphics.FromImage(MultipleImage);

            // информация о кол-ве картинок
            System.Drawing.Imaging.PropertyItem piCnt = (System.Drawing.Imaging.PropertyItem)Activator.CreateInstance(typeof(System.Drawing.Imaging.PropertyItem), true);
            piCnt.Id = 1;
            piCnt.Type = 4;
            piCnt.Value = BitConverter.GetBytes(BitmapImages.Count);
            piCnt.Len = BitConverter.GetBytes(BitmapImages.Count).Length;
            (MultipleImage as System.Drawing.Image).SetPropertyItem(piCnt);

            Int32 CurX = 0;
            Int32 CurY = 0;
            foreach (Bitmap bm in BitmapImages)
            {
                // информация о размере картинки
                System.Drawing.Imaging.PropertyItem piW = (System.Drawing.Imaging.PropertyItem)Activator.CreateInstance(typeof(System.Drawing.Imaging.PropertyItem), true);
                piW.Id = BitmapImages.IndexOf(bm) * 10 + 10;
                piW.Type = 4;
                piW.Value = BitConverter.GetBytes(bm.Width);
                piW.Len = BitConverter.GetBytes(bm.Width).Length;
                (MultipleImage as System.Drawing.Image).SetPropertyItem(piW);

                System.Drawing.Imaging.PropertyItem piH = (System.Drawing.Imaging.PropertyItem)Activator.CreateInstance(typeof(System.Drawing.Imaging.PropertyItem), true);
                piH.Id = BitmapImages.IndexOf(bm) * 10 + 11;
                piH.Type = 4;
                piH.Value = BitConverter.GetBytes(bm.Height);
                piH.Len = BitConverter.GetBytes(bm.Height).Length;
                (MultipleImage as System.Drawing.Image).SetPropertyItem(piH);

                g.DrawImage(bm, new Rectangle(CurX, CurY, bm.Width, bm.Height));
                CurY += bm.Height;

                // чистим память
                bm.Dispose();
            }

            // результат
            MultipleImage.Save(MtplImage, System.Drawing.Imaging.ImageFormat.Jpeg);

            // чистим память
            MultipleImage.Dispose();
            g.Dispose();
        }
        # endregion

        # region Конструктор/Деструктор
        public MultipleImage()
        {
            this._Images = new List<String>();
        }
        ~MultipleImage()
        {
            Dispose(false);
        }
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                RemoveAll();
            }
            isDisposed = true;
        }
        # endregion
    }
}