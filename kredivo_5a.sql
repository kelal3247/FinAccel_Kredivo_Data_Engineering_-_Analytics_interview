select
case
	when cust.age <= 20 then '<= 20'
	when cust.age > 20 and cust.age <= 30 then '21-30'
	when cust.age > 30 and cust.age <= 40 then '31-40'
	when cust.age > 40 and cust.age <= 50 then '41-50'
	when cust.age > 50 then '>= 51'
end age_bucket
, array_to_string((array_agg(tr.amount::character varying ORDER BY tr.amount desc))[1:3], ', ') AS top_3_principal
, array_to_string((array_agg(tr.amount::character varying ORDER BY tr.amount))[1:3], ', ') AS top_3_principal
, array_to_string((array_agg(cust.cust_id::character varying ORDER BY tr.amount desc))[1:3], ', ') AS top_3_principal
, array_to_string((array_agg(cust.cust_id::character varying ORDER BY tr.amount))[1:3], ', ') AS top_3_principal
from public.transaction tr
join public.customer cust
on tr.cust_id = cust.cust_id
group by 1
;