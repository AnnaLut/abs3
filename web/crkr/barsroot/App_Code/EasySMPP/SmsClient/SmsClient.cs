using System;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading;
using System.Xml.Serialization;



namespace EasySMPP
{
    public class SmsClient
    {
        private SMPPClient smppClient;
        private int lastStatusCode = 0;
        private string lastStatusDesc = string.Empty; 
        private int waitForResponse = 30000;
        private SortedList<int, AutoResetEvent> events = new SortedList<int, AutoResetEvent>();
        private SortedList<int, int> statusCodes = new SortedList<int, int>();
        #region Properties
        public int WaitForResponse
        {
            get { return waitForResponse; }
            set { waitForResponse = value; }
        }
        public bool CanSend
        {
            get { return smppClient.CanSend; }
        }
        public int LastStatusCode
        {
            get { return lastStatusCode; }
        }
        public string LastStatusDesc
        {
            get { return lastStatusDesc; }
        }

        #endregion Properties

        #region Public functions
        public SmsClient()
        {
            smppClient = new SMPPClient();

            smppClient.OnDeliverSm += new DeliverSmEventHandler(onDeliverSm);
            smppClient.OnSubmitSmResp += new SubmitSmRespEventHandler(onSubmitSmResp);

            smppClient.OnLog += new LogEventHandler(onLog);
            smppClient.LogLevel = LogLevels.LogDebug;

            LoadConfig();

            smppClient.Connect();

        }
        public void Connect()
        {
            smppClient.Connect();
        }
        public void Disconnect()
        {
            smppClient.Disconnect();
        }
        public bool SendSms(string from, string to, string text)
        {
            bool result = false;
            if (smppClient.CanSend)
            {
                AutoResetEvent sentEvent;
                int sequence;
                lock (events)
                {
                    sequence = smppClient.SendSms(from, to, text);
                    sentEvent = new AutoResetEvent(false);
                    events[sequence] = sentEvent;
                }
                if (sentEvent.WaitOne(waitForResponse, true))
                {
                    lock (events)
                    {
                        events.Remove(sequence);
                    }
                    int statusCode;
                    bool exist;
                    lock (statusCodes)
                    {
                        exist = statusCodes.TryGetValue(sequence, out statusCode);
                        lastStatusCode = statusCode;
                    }
                    if (exist)
                    {
                        lock (statusCodes)
                        {
                            statusCodes.Remove(sequence);
                        }
                        if (statusCode == StatusCodes.ESME_ROK)
                            result = true;
                    }
                }
            }
            return result;
        }

        #endregion Public functions

        #region Events

        public event NewSmsEventHandler OnNewSms;

        public event LogEventHandler OnLog;

        #endregion Events

        #region Private functions
        private void onDeliverSm(DeliverSmEventArgs args)
        {
            smppClient.sendDeliverSmResp(args.SequenceNumber, StatusCodes.ESME_ROK);
            if (OnNewSms != null)
                OnNewSms(new NewSmsEventArgs(args.From, args.To, args.TextString));
        }
        private void onSubmitSmResp(SubmitSmRespEventArgs args)
        {
            AutoResetEvent sentEvent;
            bool exist;
            lock (events)
            {
                exist = events.TryGetValue(args.Sequence, out sentEvent);
            }
            if (exist)
            {
                lock (statusCodes)
                {
                    statusCodes[args.Sequence] = args.Status;
                    lastStatusCode = args.Status;
                }
                sentEvent.Set();
            }
        }
        private void onLog(LogEventArgs args)
        {
            //Console.WriteLine(args.Message);
            lastStatusDesc += args.Message + Environment.NewLine;
            if (OnLog != null)
                OnLog(args);
        }
        private void LoadConfig()
        {
            // загружаем из bars_webconfig
         /*   SMSC smsc = new SMSC();
            smsc.Description = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.Description"];
            smsc.Host = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.Host"];
            smsc.Port = Convert.ToInt32(Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.Port"]);
            smsc.SystemId = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.SystemId"];
            smsc.Password = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.Password"];
            smsc.SystemType = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.SystemType"];
            smsc.AddrTon = Convert.ToByte(Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.AddrTon"]);
            smsc.AddrNpi = Convert.ToByte(Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.AddrNpi"]);
            smsc.AddressRange = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.AddressRange"];
                        
            smppClient.AddSMSC(smsc); 
            */
            
            // оригинальная вычитка
          
			 try
            {
                   SMSC smsc = new SMSC();
           smsc.Description = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.Description"];
           smsc.Host = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.Host"];
           smsc.Port = Convert.ToInt32(Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.Port"]);
           smsc.SystemId = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.SystemId"];
           smsc.Password = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.Password"];
           smsc.SystemType = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.SystemType"];
           smsc.AddrTon = Convert.ToByte(Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.AddrTon"]);
           smsc.AddrNpi = Convert.ToByte(Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.AddrNpi"]);
           smsc.AddressRange = Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.AddressRange"];
                        
           smppClient.AddSMSC(smsc); 
           
              /*  XmlSerializer serializer = new XmlSerializer(typeof(SMSC));

                String CFGPath = @"c:\inetpub\wwwroot\barsroot\App_Code\EasySMPP\smsc.cfg";

                if (!File.Exists(CFGPath))
                {
                    using (TextWriter writer = new StreamWriter(CFGPath))
                    {
                        serializer.Serialize(writer, new SMSC("example", "77.120.116.102", 29900, "muzykaoc", "london", "", 0, 0, "", 0));
                    }
                    onLog(new LogEventArgs("Please edit smsc.cfg and enter your data."));
                }
                using (FileStream fs = new FileStream(CFGPath, FileMode.Open))
                {
                    SMSC smsc = (SMSC)serializer.Deserialize(fs);
                    smppClient.AddSMSC(smsc);
                }*/
            }
            catch (Exception ex)
            {
                onLog(new LogEventArgs("Error on loading smsc.cfg : " + ex.Message));
            }
        }

        #endregion


    }
}
