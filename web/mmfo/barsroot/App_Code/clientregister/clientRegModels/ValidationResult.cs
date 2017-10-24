namespace clientregister
{ 
	/// <summary>
	/// Результат валидации
	/// </summary>
	public class ValidationResult
	{
		public string Status { get; set; }
		public string Message { get; set; }

		public string Code;
		public string Text;
		public string Param;

		public ValidationResult(string code, string text)
		{
			Code = code;
			Status = code;

			Text = text;
			Message = text;
		}
		public ValidationResult(string code)
			: this(code, string.Empty)
		{
		}
		public ValidationResult()
		{
		}
	}
}