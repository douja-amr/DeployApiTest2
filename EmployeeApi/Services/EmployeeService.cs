using EmployeeApi.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeeApi.Services
{
    public class EmployeeService : IEmployeeService
    {
        private readonly EmployeeDbContext _db;


         
        public EmployeeService(EmployeeDbContext db)
        {
            _db = db;
        }

        public async Task<string> GetEmployeebyId(int EmpID)
        {
            var name = await _db.Employees.Where(c => c.Id == EmpID).Select(d => d.Name).FirstOrDefaultAsync();
            return name;
        }

        public async Task<Employee> GetEmployeeDetails(int EmpID)
        {
            var emp = await _db.Employees.FirstOrDefaultAsync(c => c.Id == EmpID);
            return emp;
        }
    }
}
