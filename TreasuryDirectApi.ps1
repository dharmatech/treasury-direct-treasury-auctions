
# https://www.treasurydirect.gov/webapis/webapisecurities.htm


# 'http://www.treasurydirect.gov/TA_WS/securities/912796CJ6/02/11/2014?format=json'


# $result = Invoke-RestMethod 'http://www.treasurydirect.gov/TA_WS/securities/search?cusip=912796CH0&format=html'




# $result = Invoke-RestMethod 'http://www.treasurydirect.gov/TA_WS/securities/search?auctionDate=2022-05-02&format=json'

$result = Invoke-RestMethod 'http://www.treasurydirect.gov/TA_WS/securities/search?auctionDate=2022-05-01,2022-05-31&format=json'

($result | Measure-Object -Property somaAccepted -Sum).Sum



# (Invoke-RestMethod 'http://www.treasurydirect.gov/TA_WS/securities/search?auctionDate=2022-05-01,2022-05-31&format=json' | Measure-Object -Property somaAccepted -Sum).Sum



function TreasuryDirect-AuctionDate($start, $end)
{
    Invoke-RestMethod ('http://www.treasurydirect.gov/TA_WS/securities/search?auctionDate={0},{1}&format=json' -f $start, $end)
}


# (TreasuryDirect-AuctionDate -start '2022-05-01' -end '2022-05-31' | Measure-Object -Property somaAccepted -Sum).Sum


# 1979-01 to 2022-08

$result = Invoke-RestMethod 'http://www.treasurydirect.gov/TA_WS/securities/search?auctionDate=1979-01-01,2022-08-31&format=json'

($result | Measure-Object -Property somaAccepted -Sum).Sum

$result | ConvertTo-Json -Depth 100 | Out-File -FilePath data-1979-Jan-2022-Aug.json

$result_alt = Get-Content .\data-1979-Jan-2022-Aug.json | ConvertFrom-Json

$result[0]

$soma_items = $result | Where-Object { $_.somaAccepted -gt 0 }

$soma_items | Format-Table