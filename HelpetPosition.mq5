#include <Trade\PositionInfo.mqh>

// Fungsi untuk mendapatkan volume total dari semua posisi terbuka untuk simbol tertentu
double GetTotalVolumeForSymbol(const string symbol)
{
    CPositionInfo positionInfo;
    double totalVolume = 0.0;
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        if (positionInfo.SelectByIndex(i) && positionInfo.Symbol() == symbol)
        {
            totalVolume += positionInfo.Volume();
        }
    }

    return totalVolume;
}

// Fungsi untuk mendapatkan total profit dari semua posisi terbuka untuk simbol tertentu
double GetTotalProfitForSymbol(const string symbol)
{
    CPositionInfo positionInfo;
    double totalProfit = 0.0;
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        if (positionInfo.SelectByIndex(i) && positionInfo.Symbol() == symbol)
        {
            totalProfit += positionInfo.Profit();
        }
    }

    return totalProfit;
}

// Fungsi untuk mendapatkan jumlah posisi terbuka untuk simbol tertentu
int GetTotalPositionsForSymbol(const string symbol)
{
    CPositionInfo positionInfo;
    int totalPositionsForSymbol = 0;
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        if (positionInfo.SelectByIndex(i) && positionInfo.Symbol() == symbol)
        {
            totalPositionsForSymbol++;
        }
    }

    return totalPositionsForSymbol;
}

// Fungsi untuk mendapatkan harga buka rata-rata dari semua posisi terbuka untuk simbol tertentu
double GetAverageOpenPriceForSymbol(const string symbol)
{
    CPositionInfo positionInfo;
    double totalVolume = 0.0;
    double totalWeightedPrice = 0.0;
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        if (positionInfo.SelectByIndex(i) && positionInfo.Symbol() == symbol)
        {
            double volume = positionInfo.Volume();
            double openPrice = positionInfo.PriceOpen();
            totalVolume += volume;
            totalWeightedPrice += volume * openPrice;
        }
    }

    if (totalVolume > 0)
    {
        return totalWeightedPrice / totalVolume;
    }

    return 0.0;
}

// Fungsi untuk menutup semua posisi terbuka untuk simbol tertentu
int CloseAllPositionsForSymbol(const string symbol)
{
    CPositionInfo positionInfo;
    int totalPositions = PositionsTotal();
    int positionsClosed = 0;

    for (int i = totalPositions - 1; i >= 0; i--)
    {
        if (positionInfo.SelectByIndex(i) && positionInfo.Symbol() == symbol)
        {
            if (positionInfo.Close())
            {
                positionsClosed++;
            }
        }
    }

    return positionsClosed;
}

// Contoh penggunaan fungsi-fungsi di atas
void OnStart()
{
    string symbol = "EURUSD";

    double totalVolume = GetTotalVolumeForSymbol(symbol);
    double totalProfit = GetTotalProfitForSymbol(symbol);
    int totalPositions = GetTotalPositionsForSymbol(symbol);
    double averageOpenPrice = GetAverageOpenPriceForSymbol(symbol);

    Print("Total Volume for ", symbol, ": ", totalVolume);
    Print("Total Profit for ", symbol, ": ", totalProfit);
    Print("Total Positions for ", symbol, ": ", totalPositions);
    Print("Average Open Price for ", symbol, ": ", averageOpenPrice);

    // Menutup semua posisi untuk simbol tertentu
    int closedPositions = CloseAllPositionsForSymbol(symbol);
    Print("Closed Positions for ", symbol, ": ", closedPositions);
}