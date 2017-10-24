using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

/// <summary>
/// Класс для работы с данными через диск
/// </summary>
namespace Bars.UserControls
{
    /// <summary>
    /// Хранение Byte данных на диске
    /// </summary>
    public class DiskData : IDisposable
    {
        # region Освобождение ресурсов
        private bool disposed = false;
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                }

                // удаляем файл
                try { File.Delete(FilePath); }
                catch { }

                disposed = true;
            }
        }
        # endregion

        # region Константы
        private const String FileNamePtrn = "data_{0}.dat";
        # endregion

        # region Приватные свойства
        private String _FilePath;
        # endregion

        # region Публичные свойства
        public String TempFolder = Path.GetTempPath() + "\\Scans\\";
        public String FilePath
        {
            get
            {
                if (String.IsNullOrEmpty(_FilePath))
                    _FilePath = TempFolder + String.Format(FileNamePtrn, Guid.NewGuid());

                if (!Directory.Exists(TempFolder))
                    Directory.CreateDirectory(TempFolder);

                return _FilePath;
            }
        }
        public Byte[] Data
        {
            get
            {
                if (!File.Exists(FilePath))
                    return null;
                else
                    return File.ReadAllBytes(FilePath);
            }
            set
            {
                if (value == null)
                    File.Delete(FilePath);
                else
                    File.WriteAllBytes(FilePath, value);
            }
        }
        public Boolean HasData
        {
            get
            {
                return File.Exists(FilePath) && this.Data.Length > 0;
            }
        }
        # endregion

        # region Публичные методы
        # endregion

        # region Приватные методы
        private void ClearTempFolder()
        {
            DirectoryInfo di = !Directory.Exists(TempFolder) ? Directory.CreateDirectory(TempFolder) : new DirectoryInfo(TempFolder);

            foreach (FileInfo fi in di.GetFiles())
                if (fi.CreationTime < DateTime.Now.AddMinutes(-20))
                {
                    try { fi.Delete(); }
                    catch { }
                }
        }
        # endregion

        # region Конструктор
        public DiskData()
        {
            ClearTempFolder();
        }
        public DiskData(Byte[] Data)
            : base()
        {
            this.Data = Data;
        }
        ~DiskData()
        {
            Dispose(false);
        }
        # endregion
    }

    /// <summary>
    /// Картинка
    /// </summary>
    public class DiskImage : IDisposable
    {
        # region Освобождение ресурсов
        private bool disposed = false;
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    if (_Main != null)
                    {
                        _Main.Dispose();
                        _Main = null;
                    }
                    if (_Thumb != null)
                    {
                        _Thumb.Dispose();
                        _Thumb = null;
                    }
                }

                disposed = true;
            }
        }
        # endregion

        # region Константы
        public const Int32 ThumbMaxLength = 300;
        # endregion

        # region Приватные свойства
        private DiskData _Main = null;
        private DiskData _Thumb = null;
        # endregion

        # region Публичные свойства
        public DiskData Main
        {
            get
            {
                return _Main;
            }
        }
        public DiskData Thumb
        {
            get
            {
                return _Thumb;
            }
        }

        public Byte[] MainData
        {
            get
            {
                if (_Main == null || !_Main.HasData)
                    return null;
                else
                    return _Main.Data;
            }
        }
        public Byte[] ThumbData
        {
            get
            {
                if (_Thumb == null || !_Thumb.HasData)
                    return null;
                else
                    return _Thumb.Data;
            }
        }

        public String MainFilePath
        {
            get
            {
                if (_Main == null || !_Main.HasData)
                    return String.Empty;
                else
                    return _Main.FilePath;
            }
        }

        public Boolean HasData
        {
            get
            {
                return _Main != null && _Main.HasData;
            }
        }
        # endregion

        # region Публичные методы
        # endregion

        # region Приватные методы
        private Byte[] CreateThumb()
        {
            using (Image ImgMain = Image.FromFile(_Main.FilePath))
            {
                Decimal ThumbSizeRatio = Convert.ToDecimal(ThumbMaxLength) / Math.Max(ImgMain.Width, ImgMain.Height);
                using (Image ImgThumb = ImgMain.GetThumbnailImage(Convert.ToInt32(ImgMain.Width * ThumbSizeRatio), Convert.ToInt32(ImgMain.Height * ThumbSizeRatio), () => false, IntPtr.Zero))
                {
                    using (MemoryStream ms = new MemoryStream())
                    {
                        ImgThumb.Save(ms, ImageFormat.Tiff);
                        return ms.ToArray();
                    }
                }
            }
        }
        # endregion

        # region Конструктор
        public DiskImage()
        {
        }
        public DiskImage(Byte[] Data, Boolean MakeThumb)
            : this()
        {
            if (Data != null && Data.Length != 0)
            {
                _Main = new DiskData(Data);
                if (MakeThumb)
                    _Thumb = new DiskData(CreateThumb());
            }
        }
        public DiskImage(Byte[] Data)
            : this(Data, true)
        {
        }
        ~DiskImage()
        {
            Dispose(false);
        }
        # endregion
    }

    /// <summary>
    /// Бинарные данные (предполагается что это многостраничная картинка)
    /// </summary>
    public class ByteData : IDisposable
    {
        # region Освобождение ресурсов
        private bool disposed = false;
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    if (_Main != null)
                    {
                        _Main.Dispose();
                        _Main = null;
                    }

                    foreach (DiskImage di in _Pages)
                    {
                        if (di != null)
                        {
                            di.Dispose();
                        }
                    }
                    this._Pages = null;
                }

                disposed = true;
            }
        }
        # endregion

        # region Константы
        # endregion

        # region Приватные свойства
        private DiskImage _Main = null;
        private DiskImage[] _Pages = null;
        private Int32 _PageCount = -1;
        # endregion

        # region Публичные свойства
        public DiskImage Main
        {
            get
            {
                return _Main;
            }
        }
        public Byte[] Data
        {
            get
            {
                if (_Main == null || !_Main.HasData)
                    return null;
                else
                    return _Main.MainData;
            }
        }
        public Boolean HasData
        {
            get
            {
                return _Main != null && _Main.HasData;
            }
        }
        public Int32 PageCount
        {
            get { return _PageCount; }
        }
        # endregion

        # region Публичные методы
        public DiskImage GetPage(Int32 idx)
        {
            if (this._Pages[idx] == null)
            {
                using (Image ImgMain = Image.FromFile(_Main.MainFilePath))
                {
                    ImgMain.SelectActiveFrame(FrameDimension.Page, idx);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        ImgMain.Save(ms, ImageFormat.Tiff);
                        this._Pages[idx] = new DiskImage(ms.ToArray(), true);
                    }
                }
            }

            return _Pages[idx];
        }
        # endregion

        # region Приватные методы
        private void InitPages()
        {
            // вычитка кол-ва страниц
            using (Image ImgMain = Image.FromFile(_Main.MainFilePath))
            {
                this._PageCount = ImgMain.GetFrameCount(FrameDimension.Page);
                this._Pages = new DiskImage[this._PageCount];
            }

            // инициализация первой страницы
            if (this._PageCount > 0)
            {
                DiskImage di = GetPage(0);
            }
        }
        # endregion

        # region Конструктор
        public ByteData()
        {
        }
        public ByteData(Byte[] Data)
            : base()
        {
			_Main = new DiskImage(Data, false);
			if (Data != null && Data.Length != 0)
            {
				InitPages();
			}
        }

        ~ByteData()
        {
            Dispose(false);
        }
        # endregion
    }
}