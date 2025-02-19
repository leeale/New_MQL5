//+------------------------------------------------------------------+
//| Enum untuk ID indikator                                            |
//+------------------------------------------------------------------+
enum ENUM_INDICATOR_ID
{
    IND_MOVING_AVERAGE,    // Moving Average ID
    IND_BOLLINGER_BANDS    // Bollinger Bands ID
};

//+------------------------------------------------------------------+
//| Class untuk mengelola handle indikator                            |
//+------------------------------------------------------------------+
class CIndicatorManager
{
private:
    int               m_handles[];    // Array untuk menyimpan handle
    ENUM_INDICATOR_ID m_ids[];       // Array untuk menyimpan ID
    int               m_total;        // Total indikator yang ditambahkan

public:
                     CIndicatorManager(void);
                    ~CIndicatorManager(void);
    
    // Method untuk menambah Moving Average
    bool             AddMA(string symbol, 
                         ENUM_TIMEFRAMES timeframe,
                         int period,
                         ENUM_MA_METHOD ma_method,
                         ENUM_APPLIED_PRICE applied_price);
    
    // Method untuk menambah Bollinger Bands
    bool             AddBB(string symbol,
                         ENUM_TIMEFRAMES timeframe,
                         int period,
                         double deviation,
                         ENUM_APPLIED_PRICE applied_price);
    
    // Method untuk mendapatkan handle berdasarkan index
    int              GetHandle(int index) const;
    
    // Method untuk mendapatkan ID indikator berdasarkan index
    ENUM_INDICATOR_ID GetIndicatorID(int index) const;
    
    // Method untuk mendapatkan total indikator
    int              GetTotal(void) const { return m_total; }
    
    // Method untuk membersihkan handle
    void             Cleanup(void);
};

//+------------------------------------------------------------------+
//| Constructor                                                        |
//+------------------------------------------------------------------+
CIndicatorManager::CIndicatorManager(void)
{
    m_total = 0;
}

//+------------------------------------------------------------------+
//| Destructor                                                         |
//+------------------------------------------------------------------+
CIndicatorManager::~CIndicatorManager(void)
{
    Cleanup();
}

//+------------------------------------------------------------------+
//| Method untuk menambah Moving Average                               |
//+------------------------------------------------------------------+
bool CIndicatorManager::AddMA(string symbol,
                            ENUM_TIMEFRAMES timeframe,
                            int period,
                            ENUM_MA_METHOD ma_method,
                            ENUM_APPLIED_PRICE applied_price)
{
    int newSize = m_total + 1;
    
    // Resize arrays
    if(ArrayResize(m_handles, newSize) == -1) return false;
    if(ArrayResize(m_ids, newSize) == -1) return false;
    
    // Buat handle baru
    int handle = iMA(symbol, timeframe, period, 0, ma_method, applied_price);
    
    if(handle != INVALID_HANDLE)
    {
        m_handles[m_total] = handle;
        m_ids[m_total] = IND_MOVING_AVERAGE;
        m_total++;
        return true;
    }
    
    return false;
}

//+------------------------------------------------------------------+
//| Method untuk menambah Bollinger Bands                              |
//+------------------------------------------------------------------+
bool CIndicatorManager::AddBB(string symbol,
                            ENUM_TIMEFRAMES timeframe,
                            int period,
                            double deviation,
                            ENUM_APPLIED_PRICE applied_price)
{
    int newSize = m_total + 1;
    
    // Resize arrays
    if(ArrayResize(m_handles, newSize) == -1) return false;
    if(ArrayResize(m_ids, newSize) == -1) return false;
    
    // Buat handle baru
    int handle = iBands(symbol, timeframe, period, deviation, 0, applied_price);
    
    if(handle != INVALID_HANDLE)
    {
        m_handles[m_total] = handle;
        m_ids[m_total] = IND_BOLLINGER_BANDS;
        m_total++;
        return true;
    }
    
    return false;
}

//+------------------------------------------------------------------+
//| Method untuk mendapatkan handle berdasarkan index                  |
//+------------------------------------------------------------------+
int CIndicatorManager::GetHandle(int index) const
{
    if(index >= m_total || index < 0)
        return INVALID_HANDLE;
        
    return m_handles[index];
}

//+------------------------------------------------------------------+
//| Method untuk mendapatkan ID indikator berdasarkan index           |
//+------------------------------------------------------------------+
ENUM_INDICATOR_ID CIndicatorManager::GetIndicatorID(int index) const
{
    if(index >= m_total || index < 0)
        return (ENUM_INDICATOR_ID)-1;
        
    return m_ids[index];
}

//+------------------------------------------------------------------+
//| Method untuk membersihkan semua handle                             |
//+------------------------------------------------------------------+
void CIndicatorManager::Cleanup(void)
{
    for(int i = 0; i < m_total; i++)
    {
        if(m_handles[i] != INVALID_HANDLE)
        {
            IndicatorRelease(m_handles[i]);
            m_handles[i] = INVALID_HANDLE;
        }
    }
    m_total = 0;
    ArrayFree(m_handles);
    ArrayFree(m_ids);
}