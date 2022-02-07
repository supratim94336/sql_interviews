-- customers who don't order (e.g. proper left join)
select cust.name as Customers
from Customers cust left join Orders ord on cust.id = ord.customerId
where ord.customerId is null;
