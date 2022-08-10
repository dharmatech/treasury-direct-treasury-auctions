
cd 'C:\Users\dharm\Dropbox\Documents\treasury-auctions'

$items = foreach ($elt in Get-ChildItem *.xml)
{
    $result = [xml](Get-Content $elt)
    $result.AuctionData.AuctionResults.SOMAAccepted
}

($items | Measure-Object -Sum).Sum

# 194,774,808,700