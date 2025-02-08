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

#include <Trade\PositionInfo.mqh>

// Fungsi untuk mendapatkan total swap dari semua posisi terbuka untuk simbol tertentu
double GetTotalSwapForSymbol(const string symbol)
{
    CPositionInfo positionInfo;
    double totalSwap = 0.0;
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        if (positionInfo.SelectByIndex(i) && positionInfo.Symbol() == symbol)
        {
            totalSwap += positionInfo.Swap();
        }
    }

    return totalSwap;
}

// Fungsi untuk mendapatkan total komisi dari semua posisi terbuka untuk simbol tertentu
double GetTotalCommissionForSymbol(const string symbol)
{
    CPositionInfo positionInfo;
    double totalCommission = 0.0;
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        if (positionInfo.SelectByIndex(i) && positionInfo.Symbol() == symbol)
        {
            totalCommission += positionInfo.Commission();
        }
    }

    return totalCommission;
}

// Fungsi untuk mendapatkan total margin yang digunakan oleh semua posisi terbuka untuk simbol tertentu
double GetTotalMarginForSymbol(const string symbol)
{
    CPositionInfo positionInfo;
    double totalMargin = 0.0;
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        if (positionInfo.SelectByIndex(i) && positionInfo.Symbol() == symbol)
        {
            totalMargin += positionInfo.Margin();
        }
    }

    return totalMargin;
}

// Fungsi untuk mendapatkan tipe posisi (buy/sell) dari posisi pertama yang ditemukan untuk simbol tertentu
ENUM_POSITION_TYPE GetPositionTypeForSymbol(const string symbol)
{
    CPositionInfo positionInfo;

    if (positionInfo.Select(symbol))
    {
        return positionInfo.Type();
    }

    return WRONG_VALUE; // Mengembalikan WRONG_VALUE jika tidak ada posisi untuk simbol tersebut
}

// Fungsi untuk mendapatkan waktu pembukaan posisi terakhir untuk simbol tertentu
datetime GetLastPositionOpenTimeForSymbol(const string symbol)
{
    CPositionInfo positionInfo;
    datetime lastOpenTime = 0;
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        if (positionInfo.SelectByIndex(i) && positionInfo.Symbol() == symbol)
        {
            datetime openTime = positionInfo.Time();
            if (openTime > lastOpenTime)
            {
                lastOpenTime = openTime;
            }
        }
    }

    return lastOpenTime;
}

// Fungsi untuk mendapatkan ticket ID dari posisi pertama yang ditemukan untuk simbol tertentu
ulong GetFirstPositionTicketForSymbol(const string symbol)
{
    CPositionInfo positionInfo;

    if (positionInfo.Select(symbol))
    {
        return positionInfo.Ticket();
    }

    return 0; // Mengembalikan 0 jika tidak ada posisi untuk simbol tersebut
}

// Contoh penggunaan fungsi-fungsi tambahan
void OnStart()
{
    string symbol = "EURUSD";

    double totalSwap = GetTotalSwapForSymbol(symbol);
    double totalCommission = GetTotalCommissionForSymbol(symbol);
    double totalMargin = GetTotalMarginForSymbol(symbol);
    ENUM_POSITION_TYPE positionType = GetPositionTypeForSymbol(symbol);
    datetime lastOpenTime = GetLastPositionOpenTimeForSymbol(symbol);
    ulong firstTicket = GetFirstPositionTicketForSymbol(symbol);

    Print("Total Swap for ", symbol, ": ", totalSwap);
    Print("Total Commission for ", symbol, ": ", totalCommission);
    Print("Total Margin for ", symbol, ": ", totalMargin);
    Print("Position Type for ", symbol, ": ", EnumToString(positionType));
    Print("Last Position Open Time for ", symbol, ": ", lastOpenTime);
    Print("First Position Ticket for ", symbol, ": ", firstTicket);
}
    string symbol = "EURUSD";

    double totalSwap = GetTotalSwapForSymbol(symbol);
    double totalCommission = GetTotalCommissionForSymbol(symbol);
    double totalMargin = GetTotalMarginForSymbol(symbol);
    ENUM_POSITION_TYPE positionType = GetPositionTypeForSymbol(symbol);
    datetime lastOpenTime = GetLastPositionOpenTimeForSymbol(symbol);
    ulong firstTicket = GetFirstPositionTicketForSymbol(symbol);

    Print("Total Swap for ", symbol, ": ", totalSwap);
    Print("Total Commission for ", symbol, ": ", totalCommission);
    Print("Total Margin for ", symbol, ": ", totalMargin);
    Print("Position Type for ", symbol, ": ", EnumToString(positionType));
    Print("Last Position Open Time for ", symbol, ": ", lastOpenTime);
    Print("First Position Ticket for ", symbol, ": ", firstTicket);
}