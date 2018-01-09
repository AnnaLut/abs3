using System;
using System.Collections;

namespace Bars.Exception
{
	//Основной клас исключений 
	public class BarsException : System.Exception
	{
		public BarsException(){}
		public BarsException(String msg) : base(msg){}
		public BarsException(String msg, System.Exception inner) : base(msg,inner){}    
		public override string Source 
		{
			get
			{
				return "Приложение .NET " + base.Source;
			}
		}
		public Hashtable MakeHashTable()
		{
			Hashtable tab = new Hashtable();
			tab.Add("MESSAGE",Message);
			tab.Add("SOURCE",Source);
			tab.Add("TRACE",StackTrace);
			return tab;
		}
	}
	//Исключение : несуществующая роль
	public class RoleException : BarsException
	{
		private string role;
		public RoleException(string role, System.Exception inner) : base(role,inner)
		{
			this.role = role;
		}    
		public RoleException(string role)
		{
			this.role = role;
	    }
		public override string StackTrace
		{
			get
			{
				return "Нужно выполнить: grant " + role + " to /user/";
			}
		}
		public override string Message
		{
			get
			{
				return "Роль " + role + " для даного пользователя не существует";
			}
		}
	}
	//Исключение : несуществующая таблица или представление
	public class TableExistException : BarsException
	{
		private string tablename;
		public TableExistException(string tablename, System.Exception inner) : base(tablename,inner){}
		public TableExistException(string tablename)
		{
			this.tablename = tablename;
		}
		public override string StackTrace
		{
			get
			{
				return "";
			}
		}
		public override string Message
		{
			get
			{
				return "Таблица или представление " + tablename + " для даного пользователя не существует";
			}
		}
	}
	public class PayException : BarsException
	{
		public PayException(String msg) : base(msg){}
	}
	public class AccountException : BarsException
	{
		public AccountException(String msg) : base(msg){}
	}
	public class BankdateClosedException : BarsException
	{
		public BankdateClosedException(String msg) : base(msg){}
	}

    /// <summary>
    /// Ошибки аутентификации
    /// </summary>
    public class AutenticationException : BarsException
    {
        public AutenticationException(string message)
            : base(message)
        {
        }

        public AutenticationException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }
    /// <summary>
    /// Срок действия истек
    /// </summary>
    public class AutenticationPasswordExpireException : AutenticationException
    {
        public AutenticationPasswordExpireException(string message)
            : base(message)
        {
        }

        public AutenticationPasswordExpireException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }

    /// <summary>
    /// Класи помилок для модулів
    /// </summary>
    public class DepositException : BarsException
    {
        public DepositException(string message)
            : base(message)
        {
        }

        public DepositException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }
    public class DocInputException : BarsException
    {
        public DocInputException(string message)
            : base(message)
        {
        }

        public DocInputException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }
    public class TechAccountsException : BarsException
    {
        public TechAccountsException(string message)
            : base(message)
        {
        }

        public TechAccountsException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }
    public class SafeDepositException : BarsException
    {
        public SafeDepositException(string message)
            : base(message)
        {
        }

        public SafeDepositException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }
    public class SocialDepositException : BarsException
    {
        public SocialDepositException(string message)
            : base(message)
        {
        }

        public SocialDepositException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }
    /// <summary>
    /// Исключение для приложения регистрации контрагента, содержит в 
    /// себе дополнительно контрол к которому относиться исключение
    /// </summary>
    public class ClientRegisterException : BarsException
    {
        private string _Message;
        private string _ControlName;

        public ClientRegisterException(string sMessage, System.Exception inner) : base(sMessage, inner) { }
        public ClientRegisterException(string sMessage, string sControlName)
        {
            _Message = sMessage;
            _ControlName = sControlName;
        }
        public override string StackTrace
        {
            get
            {
                return "";
            }
        }
        public override string Message
        {
            get
            {
                return _Message;
            }
        }
        public string ControlName
        {
            get
            {
                return _ControlName;
            }
        }
    }
    /// <summary>
    /// Исключение приложения просмотра карточки доумента
    /// </summary>
    public class DocumentViewException : BarsException
    {
        public DocumentViewException(string message)
            : base(message)
        {
        }

        public DocumentViewException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }
}
