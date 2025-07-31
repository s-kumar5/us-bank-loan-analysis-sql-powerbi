--Total Loan Applications
select COUNT(id ) as total_applications from Bank_loan_data;

--MTD Loan Applications
select COUNT(id) as total_applications from Bank_loan_data
where MONTH(issue_date)=12 ;

--PMTD Loan Applications
select COUNT(id) as total_applications from Bank_loan_data
where MONTH(issue_date) =11;

--Total Funded Amount
select SUM( loan_amount) as Total_funded_amount from Bank_loan_data;

--MTD Total Funded Amount
select SUM(loan_amount) as mtd_total_funded_amount from Bank_loan_data
where MONTH(issue_date) =12
and YEAR(issue_date) =2021;

--PMTD Total Funded Amount
select SUM(loan_amount) as pmtd_total_funded_amount from Bank_loan_data
where MONTH(issue_date) =11
and YEAR(issue_date) =2021;

--Total Amount Received
select SUM(total_payment) as total_amount_received from Bank_loan_data;

--MTD Total Funded Amount
select SUM(total_payment) as mtd_total_amount_received from Bank_loan_data
where month(issue_date) = 12 and YEAR(issue_date) =2021;

-- PMTD Total Funded Amount
select SUM(total_payment) as pmtd_total_amount_received from Bank_loan_data
where month(issue_date) = 11 and YEAR(issue_date) =2021;

--Average Interest Rate
select AVG(int_rate)*100 as avg_int_rate from Bank_loan_data;
select concat(round(AVG(int_rate)*100,2),'%') as avg_int_rate from Bank_loan_data;

--MTD Average Interest
select AVG(int_rate)*100 as mtd_avg_int_rate from Bank_loan_data
where MONTH(issue_date) = 12;

--PMTD Average Interest
select AVG(int_rate ) * 100 as pmtd_avg_int_rate from Bank_loan_data
where MONTH(issue_date) =11;

--Avg DTI
select concat(round(AVG(dti) *100,2),'%') as avg_dti from Bank_loan_data;
select AVG(dti) *100 as avg_dti from Bank_loan_data;\

--MTD Avg DTI
select AVG(dti) * 100 as mtd_avg_dti from Bank_loan_data 
where MONTH(issue_date)=12;

--PMTD Avg DTI
select AVG(dti) * 100 as mtd_avg_dti from Bank_loan_data 
where MONTH(issue_date)=11;

--Good Loan Percentage
select concat((COUNT(case when loan_status ='fully paid' or loan_status = 'current' then id end)*100) /
count(id),'%') as good_loan_percentage from bank_loan_data;

select (COUNT(case when loan_status ='fully paid' or loan_status = 'current' then id end)*100.0) /
count(id) as good_loan_percentage from bank_loan_data;

--Good Loan Applications
select COUNT(id) as good_loan_applications from Bank_loan_data
where loan_status in ('fully paid' , 'current');

select COUNT(id) as good_loan_applications from Bank_loan_data
where loan_status = 'fully paid' or loan_status= 'current' ;

--Good Loan Funded Amount
select SUM(loan_amount) as good_loan_funded_amount from Bank_loan_data
where loan_status in ('fully paid' ,'current');

--Good Loan Amount Received
select SUM(total_payment) as good_loan_amount_received from Bank_loan_data
where loan_status = 'fully paid' or loan_status = 'current' ;

--Bad Loan Percentage
select (count(case when loan_status='charged off ' then id end ) *100) / COUNT(id) 
as bad_loan_percentage from Bank_loan_data;

--Bad Loan Applications
select COUNT(id) as bad_loan_applications from Bank_loan_data
where loan_status='charged off';

--Bad Loan Funded Amount
select SUM(loan_amount) as bad_loan_funded_amount from Bank_loan_data
where loan_status = 'charged off ' ;

--Bad Loan Amount Received
select SUM(total_payment) as bad_loan_amount_received from Bank_loan_data
where loan_status = 'charged off';

--LOAN STATUS
select Loan_status ,COUNT(id) as LoanCount ,SUM(total_payment) as Total_amount_received ,
SUM(loan_amount) as Total_funded_amount,AVG(int_rate * 100) as Interest_rate ,AVG(dti *100 ) as Dti
from Bank_loan_data group by loan_status;

select Loan_status , SUM(loan_amount) as MTD_total_funded_amount , SUM(total_payment) as MTD_total_amount_received
from Bank_loan_data where MONTH(issue_date) = 12 group by loan_status;

--BANK LOAN REPORT | OVERVIEW
select MONTH(issue_date) as Month_number ,DATENAME(month,issue_date) as Month_name ,COUNT(ID) as Total_loan_applications,
SUM(loan_amount) as Total_funded_amount ,SUM(total_payment) as Total_amount_received from Bank_loan_data
group by MONTH(issue_date) , DATENAME(month,issue_date) order by MONTH(issue_date) ;

--STATE WISE REPORT
select Address_state  as State , count(id) as Total_loan_applications,sum(loan_amount) as Total_funded_amount ,
sum(total_payment) as Total_amount_received from Bank_loan_data group by address_state order by address_state;

--TERM WISE REPORT	
select term as Term,COUNT(id) as Total_loan_applications,SUM(loan_amount) as Total_funded_amount 
,SUM(total_payment) as Total_amount_received from Bank_loan_data group by term order by term;

--EMPLOYEE LENGTH WISE REPORT
select emp_length as Employee_length,COUNT(id) as Total_loan_applications,SUM(loan_amount) as Total_funded_amount 
,SUM(total_payment) as Total_amount_received from Bank_loan_data group by emp_length order by emp_length;


--PURPOSE WISE REPORT
select purpose	 as Purpose ,COUNT(id) as Total_loan_applications,SUM(loan_amount) as Total_funded_amount 
,SUM(total_payment) as Total_amount_received from Bank_loan_data group by purpose order by purpose;

-- HOME OWNERSHIP WISE REPORT
select home_ownership as Home_ownership ,COUNT(id) as Total_loan_applications,SUM(loan_amount) as Total_funded_amount 
,SUM(total_payment) as Total_amount_received from Bank_loan_data group by home_ownership order by home_ownership;


---- REPORT WITH FILTER
select purpose	 as Purpose ,COUNT(id) as Total_loan_applications,SUM(loan_amount) as Total_funded_amount 
,SUM(total_payment) as Total_amount_received from Bank_loan_data
where grade = 'a' group by purpose order by purpose;

select home_ownership as Home_ownership ,COUNT(id) as Total_loan_applications,SUM(loan_amount) as Total_funded_amount 
,SUM(total_payment) as Total_amount_received from Bank_loan_data 
where grade = 'a' and address_state = 'ca' Group by home_ownership order by count(ID) ;
