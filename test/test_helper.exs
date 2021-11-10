{:ok, _} = Application.ensure_all_started(:ex_machina)
{:ok, _} = ExploringMars.GetProbeData.start_link([])
ExUnit.start()
