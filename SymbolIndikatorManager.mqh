//+------------------------------------------------------------------+
//| Class untuk mengelola indikator untuk multiple symbol              |
//+------------------------------------------------------------------+
class CSymbolIndicatorManager
{
private:
    CIndicatorManager* m_managers[];  // Array of indicator managers
    string            m_symbols[];    // Array of symbols
    int               m_total;        // Total symbols being managed

public:
                     CSymbolIndicatorManager(void);
                    ~CSymbolIndicatorManager(void);
    
    // Method untuk menambah symbol baru
    bool             AddSymbol(string symbol);
    
    // Method untuk menambah MA ke symbol tertentu
    bool             AddMA(string symbol,
                         ENUM_TIMEFRAMES timeframe,
                         int period,
                         ENUM_MA_METHOD ma_method,
                         ENUM_APPLIED_PRICE applied_price);
    
    // Method untuk menambah BB ke symbol tertentu
    bool             AddBB(string symbol,
                         ENUM_TIMEFRAMES timeframe,
                         int period,
                         double deviation,
                         ENUM_APPLIED_PRICE applied_price);
    
    // Method untuk mendapatkan manager berdasarkan symbol
    CIndicatorManager* GetManagerBySymbol(string symbol);
    
    // Method untuk mendapatkan index symbol
    int              GetSymbolIndex(string symbol) const;
    
    // Method untuk mendapatkan total symbol
    int              GetTotal(void) const { return m_total; }
    
    // Method untuk membersihkan semua data
    void             Cleanup(void);
};

//+------------------------------------------------------------------+
//| Constructor                                                        |
//+------------------------------------------------------------------+
CSymbolIndicatorManager::CSymbolIndicatorManager(void)
{
    m_total = 0;
}

//+------------------------------------------------------------------+
//| Destructor                                                         |
//+------------------------------------------------------------------+
CSymbolIndicatorManager::~CSymbolIndicatorManager(void)
{
    Cleanup();
}

//+------------------------------------------------------------------+
//| Method untuk menambah symbol baru                                  |
//+------------------------------------------------------------------+
bool CSymbolIndicatorManager::AddSymbol(string symbol)
{
    // Check if symbol already exists
    if(GetSymbolIndex(symbol) != -1)
        return false;
        
    int newSize = m_total + 1;
    
    // Resize arrays
    if(ArrayResize(m_managers, newSize) == -1) return false;
    if(ArrayResize(m_symbols, newSize) == -1) return false;
    
    // Create new indicator manager
    m_managers[m_total] = new CIndicatorManager();
    if(m_managers[m_total] == NULL) return false;
    
    m_symbols[m_total] = symbol;
    m_total++;
    
    return true;
}

//+------------------------------------------------------------------+
//| Method untuk menambah MA ke symbol tertentu                        |
//+------------------------------------------------------------------+
bool CSymbolIndicatorManager::AddMA(string symbol,
                                  ENUM_TIMEFRAMES timeframe,
                                  int period,
                                  ENUM_MA_METHOD ma_method,
                                  ENUM_APPLIED_PRICE applied_price)
{
    CIndicatorManager* manager = GetManagerBySymbol(symbol);
    if(manager == NULL)
    {
        if(!AddSymbol(symbol))
            return false;
        manager = GetManagerBySymbol(symbol);
    }
    
    return manager.AddMA(symbol, timeframe, period, ma_method, applied_price);
}

//+------------------------------------------------------------------+
//| Method untuk menambah BB ke symbol tertentu                        |
//+------------------------------------------------------------------+
bool CSymbolIndicatorManager::AddBB(string symbol,
                                  ENUM_TIMEFRAMES timeframe,
                                  int period,
                                  double deviation,
                                  ENUM_APPLIED_PRICE applied_price)
{
    CIndicatorManager* manager = GetManagerBySymbol(symbol);
    if(manager == NULL)
    {
        if(!AddSymbol(symbol))
            return false;
        manager = GetManagerBySymbol(symbol);
    }
    
    return manager.AddBB(symbol, timeframe, period, deviation, applied_price);
}

//+------------------------------------------------------------------+
//| Method untuk mendapatkan manager berdasarkan symbol                |
//+------------------------------------------------------------------+
CIndicatorManager* CSymbolIndicatorManager::GetManagerBySymbol(string symbol)
{
    int index = GetSymbolIndex(symbol);
    if(index == -1)
        return NULL;
        
    return m_managers[index];
}

//+------------------------------------------------------------------+
//| Method untuk mendapatkan index symbol                              |
//+------------------------------------------------------------------+
int CSymbolIndicatorManager::GetSymbolIndex(string symbol) const
{
    for(int i = 0; i < m_total; i++)
    {
        if(m_symbols[i] == symbol)
            return i;
    }
    return -1;
}

//+------------------------------------------------------------------+
//| Method untuk membersihkan semua data                               |
//+------------------------------------------------------------------+
void CSymbolIndicatorManager::Cleanup(void)
{
    for(int i = 0; i < m_total; i++)
    {
        if(m_managers[i] != NULL)
        {
            m_managers[i].Cleanup();
            delete m_managers[i];
            m_managers[i] = NULL;
        }
    }
    
    m_total = 0;
    ArrayFree(m_managers);
    ArrayFree(m_symbols);
}