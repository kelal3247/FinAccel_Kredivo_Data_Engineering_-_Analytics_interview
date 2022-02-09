-- soal no 1
select 
cust.age
, cust.gender
, sum(tr.amount) amount_transaction
from public.transaction tr
join public.customer cust
on tr.cust_id = cust.cust_id
group by cust.age, cust.gender
;

-- soal no 2
with 
master as (
	select
	cust.cust_id
	, cust.age
	, 'Master Degree' education
	, cust.gender
	from public.customer cust
	where cust.education like 'Master%'
)
, non_master as (
	select 
	*
	from public.customer cust
	where not exists (
		SELECT * FROM master me WHERE me.cust_id = cust.cust_id
	)
)
select
new_tr.education
, count(distinct new_tr.cust_id)
from (
	select 
	tr.loan_id
	, tr.cust_id
	, master.age
	, master.education
	, tr.loan_status
	, tr.amount
	, tr.tenure
	, tr.eff_date
	, tr.due_date
	, tr.paid_off_time
	, tr.past_due_days
	from public.transaction tr
	join master master
	on tr.cust_id = master.cust_id

	union

	select 
	tr.loan_id
	, tr.cust_id
	, non_master.age
	, non_master.education
	, tr.loan_status
	, tr.amount
	, tr.tenure
	, tr.eff_date
	, tr.due_date
	, tr.paid_off_time
	, tr.past_due_days
	from public.transaction tr
	join non_master non_master
	on tr.cust_id = non_master.cust_id
	) new_tr
group by new_tr.education
;