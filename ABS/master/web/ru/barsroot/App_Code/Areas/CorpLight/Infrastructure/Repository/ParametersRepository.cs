﻿using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.CorpLight.Models;
using Models;

namespace BarsWeb.Areas.CorpLight.Infrastructure.Repository
{
    /// <summary>
    /// Class for managing parameters
    /// </summary>
    public class ParametersRepository : IParametersRepository
    {
        /// <summary>
        /// Data access class
        /// </summary>
        readonly EntitiesBars _entities;

        /// <summary>
        /// Name of the table with parameters
        /// </summary>
        private string _moduleParamTableName = "bars.MBM_PARAMETERS";
        public ParametersRepository(ICorpLightModel model)
        {
            _entities = model.CorpLightEntities;
        }

        /// <summary>
        /// Get all parameters from the parameters table
        /// </summary>
        /// <returns></returns>
        public IEnumerable<Parameter> GetAll()
        {
            var sql = string.Format(
                      @"select 
                            PARAMETER_NAME as ""Name"",
                            PARAMETER_VALUE as ""Value"",
                            DESCRIPTION as ""Description""
                      from 
                            {0}", _moduleParamTableName);
            var result = _entities.ExecuteStoreQuery<Parameter>(sql).ToList();
            return result;
        }

        /// <summary>
        /// Get parameters from table
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public Parameter Get(string name)
        {
            var sql = string.Format(
                      @"select 
                            PARAMETER_NAME as ""Name"",
                            PARAMETER_VALUE as ""Value"",
                            DESCRIPTION as ""Description""
                      from 
                            {0}
                      where
                            PARAMETER_NAME = :p_name", _moduleParamTableName);
            var result = _entities.ExecuteStoreQuery<Parameter>(sql, name).FirstOrDefault();
            return result;
        }

        /// <summary>
        /// Add parameter
        /// </summary>
        /// <param name="parameter"></param>
        public void Add(Parameter parameter)
        {
            if (string.IsNullOrEmpty(parameter.Name))
            {
                throw new Exception("Property Name is empty");
            }
            var parameterInBase = Get(parameter.Name);
            if (parameterInBase == null)
            {
                MakeAdd(parameter);
            }
        }

        /// <summary>
        /// Delete parameter
        /// </summary>
        /// <param name="name"></param>
        public void Delete(string name)
        {
            if (!string.IsNullOrEmpty(name))
            {
                var sql = string.Format(
                      @"delete from {0} where PARAMETER_NAME = :p_name", _moduleParamTableName);
                _entities.ExecuteStoreCommand(sql, name);
            }
        }

        /// <summary>
        /// Update parameter
        /// </summary>
        /// <param name="parameter"></param>
        public void Update(Parameter parameter)
        {
            if (string.IsNullOrEmpty(parameter.Name))
            {
                throw new Exception("Property Name is empty");
            }
            var parameterInBase = Get(parameter.Name);
            if (parameterInBase == null)
            {
                throw new Exception("Parameter " + parameter.Name + " not found");   
            }
            MakeUpdate(parameter);
        }

        /// <summary>
        /// Add or update parameter
        /// </summary>
        /// <param name="parameter"></param>
        public void AddOrUpdate(Parameter parameter)
        {
            if (string.IsNullOrEmpty(parameter.Name))
            {
                throw new Exception("Property Name is empty");
            }
            var parameterInBase = Get(parameter.Name);
            if (parameterInBase == null)
            {
                MakeAdd(parameter);
            }
            else
            {
                MakeUpdate(parameter);
            }
        }

        /// <summary>
        /// Update parameter
        /// </summary>
        /// <param name="parameter"></param>
        private void MakeUpdate(Parameter parameter)
        {
            var sql = string.Format( 
                      @"update {0} set PARAMETER_VALUE = :p_value, DESCRIPTION = :p_description
                            where PARAMETER_NAME = :p_name", _moduleParamTableName);
            _entities.ExecuteStoreCommand(sql, parameter.Value, parameter.Description, parameter.Name);
        }

        /// <summary>
        /// Add new parameter
        /// </summary>
        /// <param name="parameter"></param>
        private void MakeAdd(Parameter parameter)
        {
            var sql = string.Format(
                      @"insert into {0} (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION) 
                            values (:p_name, :p_value, :p_description)", _moduleParamTableName);
            _entities.ExecuteStoreCommand(sql, parameter.Name, parameter.Value, parameter.Description);
        }
    }

    public interface IParametersRepository
    {
        IEnumerable<Parameter> GetAll();
        Parameter Get(string name);
        void Add(Parameter parameter);
        void Delete(string name);
        void Update(Parameter parameter);
        void AddOrUpdate(Parameter parameter);
    }
}