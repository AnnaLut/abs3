﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;

using System.Drawing;

using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;

/// <summary>
/// картинка для календаря на сторінці авторизації
/// </summary>
public class CalendarImageBuilder
{
    private const int ImgWidth = 385;
    private const int ImgHeight = 340;
    private const string FamilyName = "Arial";
    private const string LogoPath = "~/content/logo/{0}";
    private const string CalendarPath = "~/content/logo/calendar.jpg";
    private const string HolidayListPath = "~/content/logo/holydays.json";
    private DateTimeFormatInfo _cultureInfo = CultureInfo.GetCultureInfo("uk-UA").DateTimeFormat;
    private readonly DateTime _date;
    private Image _img = null;
    private Graphics _canvas;
    private bool _isHoliday;

    public CalendarImageBuilder(DateTime date)
    {
        _date = date;
    }

    public ImageInfo Draw()
    {

        //поиск праздника
        var holiday = FindHoliday();

       //инфо о созданном файле
        return new ImageInfo
        {
            Image = _img,
            FileName = holiday != null ? holiday.FileName : "calendar.jpg",
            ImageDescription = holiday != null
                ? String.Format("{0} - {1}", GetFileDate(holiday).ToString("dd MMMMM", _cultureInfo),
                    holiday.FileDesc)
                : "ABC Bars-WEB",
            CultureInfo = _cultureInfo,
            IsHoliday = holiday != null
        };
    }

    private void DrawText()
    {

        var color1 = new SolidBrush(Color.FromArgb(102, 102, 102));
        var color2 = new SolidBrush(Color.FromArgb(0, 188, 242));
        var color3 = new SolidBrush(Color.FromArgb(127, 186, 0));

        String month = _date.ToString("MMMM", _cultureInfo);
        String day = _date.ToString("dd", _cultureInfo);
        String week = _date.ToString("dddd", _cultureInfo);

        if (_isHoliday)
        {
            SetTransparentRect(40, 200);
            DrawWord(5, 30, color3, _date.ToString("dd MMMMM, dddd", _cultureInfo));
        }
        else
        {
            SetTransparentRect(ImgHeight, 220);
            DrawWord(40, 30, color1, month);
            DrawWord(90, 100, color2, day);
            DrawWord(240, 30, color3, week);
        }
    }

    private void DrawWord(int yOffset, int fontSize, Brush color, String text)
    {
        var font = new Font(FamilyName, fontSize);
        var sz = _canvas.MeasureString(text, font);
        _canvas.DrawString(text, font, color, (ImgWidth - sz.Width)/2, yOffset);
    }

    private DayImageFile FindHoliday()
    {
        //список праздничных дней
        Stream fs = File.OpenRead(HttpContext.Current.Server.MapPath(HolidayListPath));
        var ser = new DataContractJsonSerializer(typeof (List<DayImageFile>));
        var res = (List<DayImageFile>) ser.ReadObject(fs);

        var holiday =
            res.SingleOrDefault(s => _date >= GetFileDate(s).AddDays(- s.Remind) && _date <= GetFileDate(s).AddDays(1));
        return holiday;
    }
    private DateTime GetEasterDate(int year)
    {
        int a = year % 19;
        int b = year % 4;
        int c = year % 7;
        int d = (19 * a + 15) % 30;
        int e = (2 * b + 4 * c + 6 * d + 6) % 7;
        int f = d + e;
        if (f <= 9) return new DateTime(year, 3, 22 + f).AddDays(13);
        else return new DateTime(year, 4, f - 9).AddDays(13);
    }
    private DateTime GetMasnicyaDay(int year)
    {
        return GetEasterDate(year).AddDays(-49);
    }
    private DateTime GetTrinityDay(int year)
    {
        return GetEasterDate(year).AddDays(49);
    }
    public void SetTransparentRect(int height, int alpha)
    {
        //var bmp = new Bitmap(image.Width, image.Height);
        using (Graphics gfx = Graphics.FromImage(_img))
        {
            var customColor = Color.FromArgb(alpha, Color.White);
            var shadowBrush = new SolidBrush(customColor);
            gfx.FillRectangles(shadowBrush, new RectangleF[] {new Rectangle(0, 0, _img.Width, height),});
        }
    }

    public DateTime GetFileDate(DayImageFile file)
    {
        var wrongDate = new DateTime(_date.Year - 1);
        if (string.IsNullOrEmpty(file.DayMonth))
        {
            switch (file.FileDesc)
            {
                case "Масляна":
                    return GetMasnicyaDay(_date.Year);
                case "Великдень":
                    return GetEasterDate(_date.Year);
                case "Трійця":
                    return GetTrinityDay(_date.Year);
                default:
                    return wrongDate;
            }
        }
        else
        {
            var dayMonth = file.DayMonth.Split('.');
            int day, month;
            if (dayMonth.Length == 2 && int.TryParse(dayMonth[0], out day) && int.TryParse(dayMonth[1], out month))
            {
                return new DateTime(_date.Year, month, day);
            }
            else return wrongDate;
        }
    }

}

[DataContract]
public class DayImageFile
{
    public DayImageFile(string fileName, string fileDesc)
    {
        this.FileName = fileName;
        this.FileDesc = fileDesc;
    }

    [DataMember]
    public String FileName { get; set; }

    [DataMember]
    public String FileDesc { get; set; }
    [DataMember]
    public String DayMonth { get; set; }

    [DataMember]
    public int Remind { get; set; }
}

public class ImageInfo
{
    public Image Image { get; set; }
    public String FileName { get; set; }
    public String ImageDescription { get; set; }
    public DateTimeFormatInfo CultureInfo { get; set; }
    public Boolean IsHoliday { get; set; }
}
