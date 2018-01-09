using System;

namespace EasySMPP
{
    public delegate void NewSmsEventHandler(NewSmsEventArgs e);

    /// <summary>
    /// Summary description for NewSmsEventArgs.
    /// </summary>
    public class NewSmsEventArgs : EventArgs
    {
        private readonly string to;
        private readonly string from;
        private readonly string text;

        public NewSmsEventArgs(string from, string to, string text)
        {
            this.from = from;
            this.to = to;
            this.text = text;
        }//NewSmsEventArgs

        public string From
        {
            get { return from; }
        }//From

        public string To
        {
            get { return to; }
        }//To

        public string Text
        {
            get { return text; }
        }//TextString

    }//NewSmsEventArgs

}