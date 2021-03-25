select c_custkey, sum(c_acctbal)
from {{ ref('playing_with_tests') }}
group by c_custkey
having sum(c_acctbal) > 100000000
