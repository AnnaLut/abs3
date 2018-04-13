using System;
using System.Linq;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using Bars.Logger;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.parser;
using Image = System.Drawing.Image;

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
                try { 
                    File.Delete(FilePath); 
                }
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
                {
                    return null;
                }
                return File.ReadAllBytes(FilePath);
            }
            set
            {
                File.WriteAllBytes(FilePath, value);
            }
        }
        public Boolean HasData
        {
            get
            {
                return File.Exists(FilePath) && this.Data != null && this.Data.Length != 0;
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
            using (MemoryStream mainImgMS = new MemoryStream())
            {
                using (BinaryWriter binWriter = new BinaryWriter(mainImgMS))
                {
                    //записать массив байтов с изображением в поток
                    binWriter.Write(this.Main.Data);

                    //считать в Image из потока
                    using (Image ImgMain = Image.FromStream(mainImgMS))
                    {
                        //создать тамбнейл и вернуть его в виде массива байт
                        Decimal ThumbSizeRatio = Convert.ToDecimal(ThumbMaxLength)/Math.Max(ImgMain.Width, ImgMain.Height);
                        using (Image ImgThumb = ImgMain.GetThumbnailImage(Convert.ToInt32(ImgMain.Width*ThumbSizeRatio), Convert.ToInt32(ImgMain.Height*ThumbSizeRatio), () => false, IntPtr.Zero))
                        {
                            using (MemoryStream thumbMS = new MemoryStream())
                            {
                                ImgThumb.Save(thumbMS, ImageFormat.Tiff);
                                return thumbMS.ToArray();
                            }
                        }
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

                    if (_Pages != null)
                    {
                        foreach (DiskImage di in _Pages)
                        {
                            if (di != null)
                            {
                                di.Dispose();
                            }
                        }
                        this._Pages = null;
                    }
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
                byte[] pdfPage = GetPageFromPdfFile(idx + 1);
                this._Pages[idx] = new DiskImage(pdfPage, true);
            }
            return _Pages[idx];
        }
        # endregion


        /// <summary>
        /// Вычитать страницу из PDF-файла и преобразовать в формат JPEG
        /// </summary>
        /// <param name="pageIndex">Номер страницы</param>
        /// <returns>Массив байт что представляет собой изображение в формате JPEG</returns>
        public byte[] GetPageFromPdfFile(int pageIndex)
        {
            //считываем PDF из файла
            using (PdfReader pdfReader = new PdfReader(_Main.MainFilePath))
            {
                //получаем страницу с переданным номером
                PdfDictionary pg = pdfReader.GetPageN(pageIndex);
                //дальше получаем картинку из pdf-объекта
                PdfDictionary res = (PdfDictionary) PdfReader.GetPdfObject(pg.Get(PdfName.RESOURCES));
                PdfDictionary xobj = (PdfDictionary) PdfReader.GetPdfObject(res.Get(PdfName.XOBJECT));
                foreach (PdfName name in xobj.Keys)
                {
                    PdfObject obj = xobj.Get(name);
                    if (obj.IsIndirect())
                    {
                        PdfDictionary tg = (PdfDictionary) PdfReader.GetPdfObject(obj);
                        string width = tg.Get(PdfName.WIDTH).ToString();
                        string height = tg.Get(PdfName.HEIGHT).ToString();
                        ImageRenderInfo imgRI =
                            ImageRenderInfo.CreateForXObject(new Matrix(float.Parse(width), float.Parse(height)),
                                (PRIndirectReference) obj, tg);

                        PdfImageObject image = imgRI.GetImage();
                        using (Image dotnetImg = image.GetDrawingImage())
                        {
                            if (dotnetImg != null)
                            {
                                using (MemoryStream ms = new MemoryStream())
                                {
                                    //сохраняем картинку в поток в формате JPEG и возвращаем в виде массива байт
                                    dotnetImg.Save(ms, ImageFormat.Jpeg);
                                    return ms.ToArray();
                                }
                            }
                        }
                    }
                }
            }
            return null;
        }

        # region Приватные методы
        private void InitPages()
        {
            // вычитка кол-ва страниц
            PdfReader pdfReader = new PdfReader(_Main.MainFilePath);
            this._PageCount = pdfReader.NumberOfPages;
            this._Pages = new DiskImage[this._PageCount];
            pdfReader.Close();
        }

        /// <summary>
        /// Получить тип переданного в конструктор файла
        /// </summary>
        /// <param name="file">Массив байт предствляющий переданный файл</param>
        /// <returns>Тип файла</returns>
        private FileType GetFileType(byte [] file)
        {
            //типа файла неопределенный - не поддерживается 
            FileType fileType = FileType.Unknown;

			if (file != null && file.Length != 0)
			{
				PdfReader pdfReader = null;
				try
				{
					//пытаемся считать файл как pdf
					pdfReader = new PdfReader(file);
					//если не выбрасывает в catch, то файл типа PDF
					fileType = FileType.Pdf;
				}
				catch (iTextSharp.text.exceptions.InvalidPdfException)
				{
					//если это не PDF, то проверяем по первым байтам может быть это TIFF
					var tiffHeader1 = new byte[] { 73, 73, 42 };
					var tiffHeader2 = new byte[] { 77, 77, 42 };

					var fileHeader = file.Take(3).ToArray();
					//если первые 3 байта переданного файла соответствуют формату TIFF
					if (tiffHeader1.SequenceEqual(fileHeader) || tiffHeader2.SequenceEqual(fileHeader))
					{
						fileType = FileType.Tiff;
					}
				}
				finally
				{
					if (pdfReader != null)
					{
						pdfReader.Close();
					}
				}
                
			}

            return fileType;
        }

        /// <summary>
        /// Конвертировать файл формата tiff в pdf
        /// </summary>
        /// <param name="data">массив байт формата tiff</param>
        /// <returns>массив байт формата pdf</returns>
        private Byte[] ConvertTiffToPdf(byte[] data)
        {
            ImageConverter imageConverter = new ImageConverter();
            MemoryStream outputMS;

            using (Image tiffImg = imageConverter.ConvertFrom(data) as Image)
            {
                if (tiffImg != null)
                {
                    using (outputMS = new MemoryStream(data))
                    {
                        //создаем PDF документ
                        Document document = new Document(PageSize.A4);
                        PdfWriter writer = PdfWriter.GetInstance(document, outputMS);
                        document.Open();
                        PdfContentByte cb = writer.DirectContent;

                        //количество картинок в многостраничном tiff файле
                        int total = tiffImg.GetFrameCount(FrameDimension.Page);

                        for (int k = 0; k < total; ++k)
                        {
                            //получаем по очереди картинки с tiff-файла и добавляем их к PDF-файлу 
                            tiffImg.SelectActiveFrame(FrameDimension.Page, k);
                            iTextSharp.text.Image img =
                                iTextSharp.text.Image.GetInstance(tiffImg, ImageFormat.Tiff);
                            img.SetAbsolutePosition(0, 0);

                            cb.AddImage(img);
                            document.NewPage();
                        }

                        document.Close();
                        writer.Close();
                    }
                }
                else
                {
                    return null;
                }
            }

            //возвращаем файл в формате PDF
            return outputMS.ToArray();
        }

        # endregion


        # region Перечисления

        /// <summary>
        /// Тип переданного файла
        /// </summary>
        private enum FileType
        {
            /// <summary>
            /// PDF - основной формат с которым идет работа
            /// </summary>
            Pdf,
            /// <summary>
            /// TIFF - раньше всё работало с файлами данного формата, для просмотра ранее загруженных файлов 
            /// в таком формате выполняется преобразование TIFF в PDF и дальнейшая работа с PDF
            /// </summary>
            Tiff,
            /// <summary>
            /// все остальные типы файлов не поддерживаются
            /// </summary>
            Unknown
        }

        # endregion 


        # region Конструктор
        public ByteData()
        {
        }
        public ByteData(Byte[] Data)
            : base()
        {
            //получаем тип переданного файла
            FileType fileType = GetFileType(Data);

            //если тип файла PDF и JPG - не выполняем никаких преобразований 
            if (fileType == FileType.Pdf)
            {
                _Main = new DiskImage(Data, false);
            }
            //если тип файла TIFF - преобразовываем в PDF
            if (fileType == FileType.Tiff)
            {
                _Main = new DiskImage(ConvertTiffToPdf(Data), false);
            }
            
            //инициализируем страницы если файл не пустой и поддерживаемого формата
            if (Data != null && Data.Length != 0 && fileType != FileType.Unknown)
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