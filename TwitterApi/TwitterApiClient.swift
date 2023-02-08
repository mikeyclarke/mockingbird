protocol TwitterApiClient {
    func getV2ReverseChronologicalTimeline() async throws -> V2ResponseBody<[V2Tweet]>
}
