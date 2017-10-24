using System;

namespace barsroot.core
{
    /// <summary>
    /// Базовое исключение для core
    /// </summary>
    public class BarsCoreException : System.Exception
    {
        public BarsCoreException() { }
        public BarsCoreException(String msg) : base(msg) { }
        public BarsCoreException(String msg, System.Exception inner) : base(msg, inner) { }
    }
}
