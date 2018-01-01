$ ->
  $('input').iCheck
    checkboxClass: 'icheckbox_flat-red'
    radioClass: 'iradio_flat-red'

  window.update_live_price()
  window.update_coin_selection()

window.update_live_price = ->
  if $('#condition_coin').val() && $('#condition_source').val()
    url = '/live_price?coin=' + $('#condition_coin').val() + '&market=' + $('#condition_source').val()
    $.getJSON url, (data) ->
      $('.js-live-price').removeClass('hidden')
      $('span.js-btc-price').text(data.btc)
      $('span.js-usd-price').text(data.usd)
      $('span.js-vnd-price').text(data.vnd)

window.update_coin_selection = ->
  coins = []

  current_coin = $('#condition_coin').val() || $('#condition_coin').data('initial-value')

  $('#condition_coin').empty()

  switch $('#condition_source').val()
    when 'coinbase'
      coins = ['BTC', 'ETH', 'LTC']
    when 'gdax'
      coins = ['BTC', 'ETH', 'LTC']
    when 'bittrex'
      coins = ["BTC","BCC","DASH","ETH","GBYTE","ZEC","XMR","BTCD","LTC","BTG","GNO","DGD","SLS","MLN","DCR","XZC","REP","OMNI","NEO","QTUM","ZEN","FCT","BLOCK","XCP","ETC","NMR","CLOAK","GAM","LSK","MCO","DMD","PART","STRAT","APX","OMG","WAVES","LUN","PIVX","KMD","MONA","SALT","CLAM","SBD","RADS","ZCL","MTL","VTC","KORE","SHIFT","ARK","VRM","NEOS","IOP","SPHR","EXP","SIB","PAY","SWT","PPC","TKS","UBQ","DYN","BNT","ANT","GAME","AEON","CLUB","NXS","TX","STEEM","VIA","IOC","BLITZ","CRW","ION","AGRS","EMC","EXCL","SNRG","EDG","NAV","GEO","TRIG","MYST","ADX","GRS","SWIFT","NXT","UNB","ARDR","QRL","BSD","ENG","STORJ","AUR","BRX","RBY","DCT","XST","XVC","INFX","PKB","TIX","LGD","NBT","FAIR","BYC","DTB","XRP","RLC","EMC2","WINGS","XEM","VRC","POWR","MAID","1ST","ERC","SYNX","CVC","AMP","MEME","BCY","RISE","MER","SYS","BLK","GNT","CPC","GUP","LBC","CURE","XEL","XMG","OK","SPR","EGC","SLR","CRB","HMQ","TRST","PTOY","VTR","VIB","INCNT","BRK","ADA","SEQ","FTC","NXC","VOX","BAT","THC","MUE","POT","EFL","RCN","QWARK","GOLOS","GLD","XVG","EBST","GCR","TRUST","XWC","BAY","GBG","XLM","CFI","ENRG","PDC","NLG","FLO","START","SNGLS","SNT","XAUR","DOPE","LMC","GRC","DNT","CANN","MANA","PTC","DGB","FLDC","BURST","PINK","FUN","ADT","MUSIC","XDN","COVAL","SC","ABY","2GIVE","XMY","BITB","RDD","DOGE"]
    when 'hitbtc'
      coins = ["BTC","BCH","DASH","ETH","ZEC","B2X","VERI","XMR","LTC","BTG","BCC","S","GNO","SMS","DGD","REP","NEO","HSR","PPT","ICOS","ETC","TIME","LSK","WAVES","PLU","STRAT","LUN","BTX","OMG","WTC","BUS","SBD","XUC","EOS","TBT","NEBL","OTN","DBIX","GRPH","TAAS","STEEM","PLBT","CNX","PPC","PAY","XTZ","BQX","SUR","SWT","WTT","GAME","BNT","AEON","ANT","ICX","EDO","CTR","EMC","ETP","BOS","ORME","EDG","EVX","ICN","DICE","NXT","ARDR","POLL","LAT","DCT","AE","RLC","VEN","ARN","ZRC","XRP","ETBS","XEM","WINGS","TKN","UGT","MAID","1ST","EMGO","PRG","BMC","LOC","SUB","PING","ODN","DLT","GUP","AMP","MCAP","ZRX","STX","ATB","OAX","IXT","AMM","RVT","TRST","MNE","PTOY","DRPU","ART","MIPS","VIB","FCN","QAU","NXC","ENEW","CL","AMB","BTM","CSNO","LRC","YOYOW","SCL","WMGO","PLR","COSS","XVG","ITS","SMART","PRS","FYP","SNC","CFI","MTH","SNGLS","OTX","ATL","ELM","XAUR","ENJ","VIBE","ZAP","FUEL","XLC","SNT","CLD","DOV","TNT","WRC","KBR","ERO","HVN","CDT","PIX","BKB","CAT","DNT","ELE","FRD","DGB","SC","LEND","FUN","HPC","CND","KICK","STU","ICO","HAC","DSH","CTX","TRX","POE","XDN","QCN","ZSC","CAPP","STORM","ATS","XDNCO","AIR","ATM","INDI","BMT","PRE","EOLD","SISA","OPT","EXN","SKIN","A","TGT","VOISE","NTO","DOGE","SWFTC","BCN","LIFE"]
    when 'poloniex'
      coins = ["BTC","BCH","DASH","ETH","ZEC","XMR","BTCD","LTC","GNO","XBC","DCR","REP","OMNI","FCT","XCP","ETC","GAS","LSK","STRAT","OMG","CLAM","SBD","RADS","VTC","NEOS","EXP","PPC","GAME","NMC","STEEM","VIA","NAV","NXT","BTM","ARDR","PASC","STORJ","XRP","XEM","EMC2","VRC","MAID","BCY","XVC","CVC","SYS","BLK","GNT","AMP","ZRX","LBC","BTS","XPM","NXC","BELA","POT","HUC","STR","RIC","FLO","GRC","DGB","FLDC","BURST","PINK","SC","DOGE","BCN"]
    else
      coins = []

  for coin in coins
    $('#condition_coin').append $('<option></option>').attr('value', coin).html(coin)

  $('#condition_coin').selectpicker('refresh')
  $('#condition_coin').selectpicker('val', current_coin)

  window.update_live_price()
