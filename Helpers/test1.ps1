$commands = @{
    setting = "hoi"
}

if ($PSBoundParameters.ContainsKey('ViewDefault')) {
    $commands['setting'] = $PSBoundParameters['ViewDefault']
}