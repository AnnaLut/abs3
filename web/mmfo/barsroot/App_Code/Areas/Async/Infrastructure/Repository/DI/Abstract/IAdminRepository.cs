using System;
using System.Collections.Generic;
using BarsWeb.Areas.Async.Models;

namespace BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract
{
    public interface IAdminRepository
    {
        /// <summary>
        /// Start task
        /// </summary>
        /// <param name="schedulerCode">Code of task scheduler</param>
        /// <param name="parameters">Parameters list</param>
        /// <returns>task code</returns>
        string StartTask(string schedulerCode, List<TaskParameter> parameters);
        /// <summary>
        /// Get scheduling parameters
        /// </summary>
        /// <param name="schedulerCode">Code of scheduler</param>
        /// <returns></returns>
        List<TaskParameter> GetSсhedulerParameters(string schedulerCode);
        /// <summary>
        /// створення нової задачі
        /// </summary>
        /// <param name="schedulerCode">код завдання з планувальника</param>
        /// <returns>код задачі</returns>
        string CreateTask(string schedulerCode);
        /// <summary>
        /// запис параметрів для задачі
        /// </summary>
        /// <param name="taskId">код задачі</param>
        /// <param name="param">ім"я параметра</param>
        /// <param name="value">значення параметра</param>
        /// <returns></returns>
        void SetTaskParamValue(string taskId,string param, int value);
        /// <summary>
        /// запис параметрів для задачі
        /// </summary>
        /// <param name="taskId">код задачі</param>
        /// <param name="param">ім"я параметра</param>
        /// <param name="value">значення параметра</param>
        /// <returns></returns>
        void SetTaskParamValue(string taskId,string param, DateTime value);
        /// <summary>
        /// запис параметрів для задачі
        /// </summary>
        /// <param name="taskId">код задачі</param>
        /// <param name="param">ім"я параметра</param>
        /// <param name="value">значення параметра</param>
        /// <returns></returns>
        void SetTaskParamValue(string taskId,string param, string value);
        /// <summary>
        /// запис параметрів для задачі
        /// </summary>
        /// <param name="taskId">код задачі</param>
        /// <param name="parameters">параметри</param>
        /// <returns></returns>
        void SetTaskParamValue(string taskId, List<TaskParameter> parameters);
        /// <summary>
        /// стартувати задачу
        /// </summary>
        /// <param name="taskId">код задачі</param>
        /// <returns></returns>
        int StartTask(string taskId);
    }
}
